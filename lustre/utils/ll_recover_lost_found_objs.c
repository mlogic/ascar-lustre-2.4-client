/*
 * GPL HEADER START
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 only,
 * as published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License version 2 for more details (a copy is included
 * in the LICENSE file that accompanied this code).
 *
 * You should have received a copy of the GNU General Public License
 * version 2 along with this program; If not, see
 * http://www.sun.com/software/products/lustre/docs/GPLv2.pdf
 *
 * Please contact Sun Microsystems, Inc., 4150 Network Circle, Santa Clara,
 * CA 95054 USA or visit www.sun.com if you need additional information or
 * have any questions.
 *
 * GPL HEADER END
 */
/*
 * Copyright (c) 2009, 2010, Oracle and/or its affiliates. All rights reserved.
 * Use is subject to license terms.
 *
 * Copyright (c) 2012, 2013, Intel Corporation.
 */
/*
 * This file is part of Lustre, http://www.lustre.org/
 * Lustre is a trademark of Sun Microsystems, Inc.
 *
 * lustre/utils/ll_recover_lost_found_objs.c
 *
 * Tool for recovering objects from lost+found that might result from a
 * Lustre OST with a corrupted directory. Running e2fsck will fix the
 * directory, but puts all of the objects into lost+found, where they are
 * inaccessible to Lustre.
 *
 * Author: Kalpak Shah <kalpak.shah@sun.com>
 */

#ifndef _GNU_SOURCE
#define _GNU_SOURCE
#endif

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <errno.h>
#include <dirent.h>
#include <sys/types.h>
#include <sys/xattr.h>
#include <sys/stat.h>

#include <liblustre.h>
#include <libcfs/list.h>

#define MAX_GROUPS 64

int verbose = 0;

struct obd_group_info {
	__u64		grp_last_id;
	__u64		grp_seq;
	cfs_list_t	grp_list;
};

cfs_list_t grp_info_list;

static void grp_info_list_destroy(cfs_list_t *list)
{
	struct obd_group_info *grp, *tmp;

	cfs_list_for_each_entry_safe(grp, tmp, list, grp_list) {
		cfs_list_del_init(&grp->grp_list);
		free(grp);
	}
}

static void usage(char *progname)
{
        fprintf(stderr, "Usage: %s [-hv] -d lost+found_directory\n", progname);
        fprintf(stderr, "You need to mount the corrupted OST filesystem and "
                "provide the path for the lost+found directory as the -d "
                "option, for example:\n"
                "ll_recover_lost_found_objs -d /mnt/ost/lost+found\n");
        exit(1);
}

static int _ll_sprintf(char *buf, size_t size, const char *func, int line,
                      const char *format, ...)
{
        int rc;
        va_list ap;

        va_start(ap, format);
        rc = vsnprintf(buf, size, format, ap);
        if (!(rc > -1 && rc < size)) {
                fprintf(stderr,
                        "error: %s:%d: path \"", func, line);
                vfprintf(stderr, format, ap);
                va_end(ap);
                fprintf(stderr, "\" is too long\n");
                return 1;
        }
        va_end(ap);
        return 0;
}

#define ll_sprintf(buf, size, format, ...) \
        _ll_sprintf(buf, size, __FUNCTION__, __LINE__, format, ## __VA_ARGS__)

static int mkdir_p(const char *dest_path, const char *mount)
{
        struct stat stat_buf;
        int retval;
        mode_t mode = 0700;

        if (stat(dest_path, &stat_buf) == 0)
                return 0;

        retval = mkdir(dest_path, mode);
        if (retval < 0) {
                fprintf(stderr, "error: creating directory %s: "
                        "%s\n", dest_path, strerror(errno));
                return 1;
        }

        return 0;
}

/* This is returning 0 for an error */
static __u64 read_last_id(char *file_path)
{
        __u64 last_id;
        int fd;
        int count;

        fd = open(file_path, O_RDONLY);
        if (fd < 0) {
                if (errno != ENOENT)
                        fprintf(stderr, "error: opening %s: %s\n",
                                        file_path, strerror(errno));
                return 0;
        }

        count = read(fd, &last_id, sizeof(last_id));
        if (count < 0) {
                fprintf(stderr, "error: reading file %s: %s\n", file_path,
                        strerror(errno));
                close(fd);
                return 0;
        }
        if (count != sizeof(last_id)) {
                fprintf(stderr, "error: Could not read full last_id from %s\n",
                        file_path);
                close(fd);
                return 0;
        }

        close(fd);
        return le64_to_cpu(last_id);
}

struct obd_group_info *find_or_create_grp(cfs_list_t *list, __u64 seq,
					  const char *mount)
{
	struct obd_group_info	*grp;
	cfs_list_t		*entry;
	char			tmp_path[PATH_MAX];
	char			seq_name[32];
	struct stat		stat_buf;
	int			retval;
	__u64			tmp_last_id;

	cfs_list_for_each(entry, list) {
		grp = (struct obd_group_info *)cfs_list_entry(entry,
						struct obd_group_info,
						grp_list);
		if (grp->grp_seq == seq)
			return grp;
	}

	grp = malloc(sizeof(struct obd_group_info));
	if (grp == NULL)
		return NULL;

	sprintf(seq_name, (fid_seq_is_rsvd(seq) ||
			   fid_seq_is_mdt0(seq)) ? LPU64 : LPX64i,
			   fid_seq_is_idif(seq) ? 0 : seq);

	/* Check whether the obj dir has been created */
	if (ll_sprintf(tmp_path, PATH_MAX, "%s/O/%s", mount, seq_name)) {
		free(grp);
		return NULL;
	}

	if (stat(tmp_path, &stat_buf) != 0) {
		retval = mkdir(tmp_path, 0700);
		if (retval < 0) {
			free(grp);
			fprintf(stderr, "error: creating directory %s: "
				"%s\n", tmp_path, strerror(errno));
			return NULL;
		}
	}

	if (ll_sprintf(tmp_path, PATH_MAX, "%s/O/%s/LAST_ID",
		       mount, seq_name)) {
		free(grp);
		return NULL;
	}

	/*
	 * Object ID needs to be verified against last_id.
	 * LAST_ID file may not be present in the group directory
	 * due to corruption. In case of any error tyr to recover
	 * as many objects as possible by setting last_id to ~0ULL.
	 */
	tmp_last_id = read_last_id(tmp_path);
	if (tmp_last_id == 0)
		tmp_last_id = ~0ULL;
	grp->grp_last_id = tmp_last_id;
	grp->grp_seq = seq;

	cfs_list_add(&grp->grp_list, list);
	return grp;
}

static unsigned filetype_dir_table[] = {
        [0]= DT_UNKNOWN,
        [S_IFIFO]= DT_FIFO,
        [S_IFCHR] = DT_CHR,
        [S_IFDIR] = DT_DIR,
        [S_IFBLK] = DT_BLK,
        [S_IFREG] = DT_REG,
        [S_IFLNK] = DT_LNK,
        [S_IFSOCK]= DT_SOCK,
#if defined(DT_DOOR) && defined(S_IFDOOR)
        [S_IFDOOR]= DT_DOOR,
#endif
};

static int traverse_lost_found(char *src_dir, const char *mount_path)
{
	DIR *dir_ptr;
	struct lustre_mdt_attrs lma;
	struct dirent64 *dirent;
	__u64 ff_seq, ff_objid;
        char *file_path;
        char dest_path[PATH_MAX];
        struct stat st;
        int obj_exists, xattr_len;
        int len, ret = 0, error = 0;
	char seq_name[32];
	char obj_name[32];
	struct obd_group_info *grp_info;

        len = strlen(src_dir);

        dir_ptr = opendir(src_dir);
        if (!dir_ptr) {
                fprintf(stderr, "error: opening directory: %s\n",
                        strerror(errno));
                return 1;
        }

        while ((dirent = readdir64(dir_ptr)) != NULL) {
                if (!strcmp(dirent->d_name, ".") ||
                    !strcmp(dirent->d_name, ".."))
                        continue;

                src_dir[len] = 0;
                if ((len + strlen(dirent->d_name) + 2) > PATH_MAX) {
                        fprintf(stderr, "error: %s/%s: path too long\n",
                                src_dir, dirent->d_name);
                        break;
                }
                strcat(src_dir, "/");
                strcat(src_dir, dirent->d_name);

                if (dirent->d_type == DT_UNKNOWN) {
                        ret = stat(src_dir, &st);
                        if (ret == -1) {
                                fprintf(stderr,
                                        "error: stating %s: %s\n",
                                        src_dir, strerror(errno));
                                continue;
                        }
                        dirent->d_type = filetype_dir_table[st.st_mode &
                                                            S_IFMT];
                        if (dirent->d_type == DT_UNKNOWN) {
                                fprintf(stderr,
                                        "error: %s of unknown type 0%o\n",
                                        src_dir, st.st_mode);
                                continue;
                        }
                }

                switch(dirent->d_type) {
                case DT_DIR:
                ret = traverse_lost_found(src_dir, mount_path);
                if (ret) {
                        closedir(dir_ptr);
                        return ret;
                }
                break;

                case DT_REG:
                file_path = src_dir;
		xattr_len = getxattr(file_path, "trusted.lma",
				     (void *)&lma, sizeof(lma));
		if (xattr_len == -1 || xattr_len < sizeof(lma)) {
			struct filter_fid_old	ff;

			/* try old filter_fid EA */
			xattr_len = getxattr(file_path, "trusted.fid",
					     (void *)&ff, sizeof(ff));
			if (xattr_len == -1 || xattr_len < sizeof(ff)) {
				/*
				 * Its very much possible that we dont find fid
				 * on precreated files, LAST_ID
				 */
				continue;
			}
			ff_seq = le64_to_cpu(ff.ff_seq);
			ff_objid = le64_to_cpu(ff.ff_objid);
		} else {
			ff_seq = le64_to_cpu(lma.lma_self_fid.f_seq);
			ff_objid = le32_to_cpu(lma.lma_self_fid.f_oid);
		}

		sprintf(seq_name, (fid_seq_is_rsvd(ff_seq) ||
				   fid_seq_is_mdt0(ff_seq)) ? LPU64 : LPX64i,
			fid_seq_is_idif(ff_seq) ? 0 : ff_seq);


		sprintf(obj_name, (fid_seq_is_rsvd(ff_seq) ||
				   fid_seq_is_mdt0(ff_seq) ||
				   fid_seq_is_idif(ff_seq)) ?
				   LPU64 : LPX64i, ff_objid);

		grp_info = find_or_create_grp(&grp_info_list, ff_seq,
					      mount_path);
		if (grp_info == NULL) {
			closedir(dir_ptr);
			return 1;
		}

                /* might need to create the parent directories for
                   this object */
		if (ll_sprintf(dest_path, PATH_MAX, "%s/O/%s/d"LPU64,
				mount_path, seq_name, ff_objid % 32)) {
			closedir(dir_ptr);
			return 1;
		}

		ret = mkdir_p(dest_path, mount_path);
		if (ret) {
			closedir(dir_ptr);
			return ret;
		}

		if (ff_objid > grp_info->grp_last_id) {
			fprintf(stderr, "error: file skipped because object ID "
				"greater than LAST_ID\nFilename: %s\n"
				"Group: "LPU64"\nObjectid: "LPU64"\n"
				"LAST_ID: "LPU64, file_path, ff_seq, ff_objid,
				grp_info->grp_last_id);
			continue;
		}

                /* move file from lost+found to proper object
                   directory */
                if (ll_sprintf(dest_path, PATH_MAX,
				"%s/O/%s/d"LPU64"/%s", mount_path,
				seq_name, ff_objid % 32, obj_name)) {
                        closedir(dir_ptr);
                        return 1;
                }

                obj_exists = 1;
                ret = stat(dest_path, &st);
                if (ret == 0) {
                        if (st.st_size == 0)
                                obj_exists = 0;
                } else {
                        if (errno != ENOENT)
                                fprintf(stderr,
                                        "warning: stat for %s: %s\n",
                                        dest_path, strerror(errno));
                        obj_exists = 0;
                }

                if (obj_exists) {
                        fprintf(stderr, "error: target object %s already "
                                "exists and will not be replaced.\n",dest_path);
                        continue;
                }

                if (rename(file_path, dest_path) < 0) {
                        fprintf(stderr, "error: rename failed for file %s: %s\n",
                                file_path, strerror(errno));
                        error++;
                        continue;
                }

                printf("Object %s restored.\n", dest_path);
                break;
                }
        }

        closedir(dir_ptr);

        return error;
}

/*
 * If LAST_ID file is not present in some group then restore it with the highest
 * object ID found in that group. By the time we come here all possible objects
 * have been restored.
 */
static int check_last_id(const char *mount_path)
{
        char lastid_path[PATH_MAX];
        char dirname[PATH_MAX], subdirname[PATH_MAX];
        DIR *groupdir, *subdir;
        struct stat st;
        struct dirent *dirent;
        __u64 group;
        __u64 max_objid;
        int fd;
        int ret;

        for (group = 0; group < MAX_GROUPS; group++) {
                max_objid = 0;

                if (ll_sprintf(dirname, PATH_MAX, "%s/O/"LPU64,
                               mount_path, group))
                        return 1;
                if (ll_sprintf(lastid_path, PATH_MAX, "%s/LAST_ID", dirname))
                        return 1;

                if (stat(lastid_path, &st) == 0)
                        continue;

                groupdir = opendir(dirname);
                if (groupdir == NULL) {
                        if (errno != ENOENT)
                                fprintf(stderr, "error: opening %s: %s\n",
                                        dirname, strerror(errno));
                        continue;
                }

                while ((dirent = readdir(groupdir)) != NULL) {
                        if (!strcmp(dirent->d_name, ".") ||
                            !strcmp(dirent->d_name, ".."))
                                continue;

                        if (ll_sprintf(subdirname, PATH_MAX, "%s/%s",
                                       dirname, dirent->d_name)) {
                                closedir(groupdir);
                                return 1;
                        }
                        subdir = opendir(subdirname);
                        if (subdir == NULL) {
                                fprintf(stderr, "error: opening %s: %s\n",
                                        subdirname, strerror(errno));
                                continue;
                        }

                        while ((dirent = readdir(subdir)) != NULL) {
                                __u64 objid;
                                char *end;

                                if (!strcmp(dirent->d_name, ".") ||
                                    !strcmp(dirent->d_name, ".."))
                                        continue;

                                objid = strtoull(dirent->d_name, &end, 0);
                                if (end == dirent->d_name || *end != 0) {
                                        fprintf(stderr, "error: unknown object"
                                                "ID %s/%s\n", subdirname,
                                                dirent->d_name);
                                        continue;
                                }
                                if (objid > max_objid)
                                       max_objid = objid;
                        }
                        closedir(subdir);
                }
                closedir(groupdir);

                fd = open(lastid_path, O_RDWR | O_CREAT, 0700);
                if (fd < 0) {
                        fprintf(stderr, "error: open \"%s\" failed: %s\n",
                                lastid_path, strerror(errno));
                        return 1;
                }

                max_objid = cpu_to_le64(max_objid);
                ret = write(fd, &max_objid, sizeof(__u64));
                if (ret < sizeof(__u64)) {
                        fprintf(stderr, "error: write \"%s\" failed: %s\n",
                                lastid_path, strerror(errno));
                        close(fd);
                        return 1;
                }

                close(fd);
        }

        return 0;
}

int main(int argc, char **argv)
{
        char *progname;
        struct stat stat_buf;
        char src_dir[PATH_MAX] = "";
        char mount_path[PATH_MAX];
        char tmp_path[PATH_MAX];
        int c;
        int retval;

	progname = argv[0];

        while ((c = getopt(argc, argv, "d:hv")) != EOF) {
                switch (c) {
                case 'd':
                        if (chdir(optarg)) {
                                fprintf(stderr, "error: chdir to %s: %s\n",
                                        optarg, strerror(errno));
                                return 1;
                        }
                        if (getcwd(src_dir, PATH_MAX) == NULL) {
                                fprintf(stderr,
                                        "error: getcwd of lost+found: %s\n",
                                        strerror(errno));
                                return 1;
                        }
                        if (chdir("..")) {
                                fprintf(stderr, "error: chdir to \"..\": %s\n",
                                        strerror(errno));
                                return 1;
                        }
                        if (getcwd(mount_path, PATH_MAX) == NULL) {
                                fprintf(stderr,
                                        "error: getcwd of mount point: %s\n",
                                        strerror(errno));
                                return 1;
                        }
                        if (!strcmp(src_dir, mount_path)) {
                                fprintf(stderr,
                                        "error: root directory is detected\n");
                                return 1;
                        }
                        fprintf(stdout, "\"lost+found\" directory path: %s\n",
                                src_dir);
                        break;
                case 'v':
                        verbose = 1;
                        break;
                case 'h':
                        usage(progname);
                default:
                        fprintf(stderr, "%s: bad option '%c'\n",
                                progname, c);
                        usage(progname);
                }
        }

        if (src_dir[0] == 0)
                usage(progname);

        /* Check if 'O' directory exists and create it if needed */
        if (ll_sprintf(tmp_path, PATH_MAX, "%s/O",  mount_path))
                return 1;

        if (stat(tmp_path, &stat_buf) != 0) {
                retval = mkdir(tmp_path, 0700);
                if (retval == -1) {
                        fprintf(stderr, "error: creating objects directory %s:"
                                " %s\n", tmp_path, strerror(errno));
                        return 1;
                }
        }

	CFS_INIT_LIST_HEAD(&grp_info_list);
        retval = traverse_lost_found(src_dir, mount_path);
        if (retval) {
                fprintf(stderr, "error: traversing lost+found looking for "
                        "orphan objects.\n");
		goto grp_destory;
	}

        retval = check_last_id(mount_path);
        if (retval)
                fprintf(stderr, "error: while checking/restoring LAST_ID.\n");

grp_destory:
	grp_info_list_destroy(&grp_info_list);
        return retval;
}
