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
 * Copyright (c) 2002, 2010, Oracle and/or its affiliates. All rights reserved.
 * Use is subject to license terms.
 */
/*
 * This file is part of Lustre, http://www.lustre.org/
 * Lustre is a trademark of Sun Microsystems, Inc.
 */

#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <errno.h>
#include <string.h>
#include <fcntl.h>
#include <unistd.h>
#include <getopt.h>

void usage(const char *prog, int status)
{
        fprintf(status == 0 ? stdout : stderr,
                "Usage: %s [OPTION]... FILE\n"
                "  -d, --device=DEV  use device number DEV\n"
                "  -h, --help        dispaly help\n"
                "  -m, --mode=MODE   use mode MODE\n"
                "  -M, --major=MAJOR use device major MAJOR\n"
                "  -N, --minor=MINOR use device minor MINOR\n",
                prog);

        exit(status);
}

int main(int argc, char ** argv)
{
        struct option opts[] = {
                { "device", 1, NULL, 'd' },
                { "help",   0, NULL, 'h' },
                { "mode",   1, NULL, 'm' },
                { "major",  1, NULL, 'M' },
                { "minor",  1, NULL, 'N' },
                { NULL },
        };
        const char *path;
        mode_t mode = S_IFREG | 0644;
        dev_t dev = 0;
        int rc;

        int c;
        while ((c = getopt_long(argc, argv, "d:hm:M:N:", opts, NULL)) != -1) {
                switch (c) {
                case 'd':
                        dev = strtoul(optarg, NULL, 0);
                        break;
                case 'h':
                        usage(argv[0], 0);
                case 'm':
                        mode = strtoul(optarg, NULL, 0);
                        break;
                case 'M':
                        dev = makedev(strtoul(optarg, NULL, 0), minor(dev));
                        break;
                case 'N':
                        dev = makedev(major(dev), strtoul(optarg, NULL, 0));
                        break;
                case '?':
                        usage(argv[0], 1);
                }
        }

        if (argc - optind != 1)
                usage(argv[0], 1);

        path = argv[optind];

        if ((mode & S_IFMT) == S_IFDIR)
                rc = mkdir(path, mode & ~S_IFMT);
        else if ((mode & S_IFMT) == S_IFLNK)
                rc = symlink("oldpath", path);
        else
                rc = mknod(path, mode, dev);

        if (rc)
                fprintf(stderr, "%s: cannot create `%s' with mode %#o: %s\n",
                        argv[0], path, mode, strerror(errno));

        return rc;
}
