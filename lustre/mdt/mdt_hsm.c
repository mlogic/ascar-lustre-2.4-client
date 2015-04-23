/*
 * GPL HEADER START
 *
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 only,
 * as published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License version 2 for more details.  A copy is
 * included in the COPYING file that accompanied this code.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 *
 * GPL HEADER END
 */
/*
 * Copyright (c) 2012, 2013, Intel Corporation.
 * Use is subject to license terms.
 * Copyright (c) 2011, 2012 Commissariat a l'energie atomique et aux energies
 *                          alternatives
 */
/*
 * lustre/mdt/mdt_hsm.c
 *
 * Lustre Metadata Target (mdt) request handler
 *
 * Author: Aurelien Degremont <aurelien.degremont@cea.fr>
 * Author: JC Lafoucriere <jacques-charles.lafoucriere@cea.fr>
 */

#ifndef EXPORT_SYMTAB
# define EXPORT_SYMTAB
#endif
#define DEBUG_SUBSYSTEM S_MDS

#include "mdt_internal.h"

/* Max allocation to satisfy single HSM RPC. */
#define MDT_HSM_ALLOC_MAX (1 << 20)

#define MDT_HSM_ALLOC(ptr, size)			\
	do {						\
		if ((size) <= MDT_HSM_ALLOC_MAX)	\
			OBD_ALLOC_LARGE((ptr), (size));	\
		else					\
			(ptr) = NULL;			\
	} while (0)

#define MDT_HSM_FREE(ptr, size) OBD_FREE_LARGE((ptr), (size))

/*
 * fake functions, will be replace by real one with HSM Coordinator patch
 */

int mdt_hsm_copytool_send(struct obd_export *exp)
{
	return 0;
}

static int mdt_hsm_coordinator_update(struct mdt_thread_info *info,
				      struct hsm_progress_kernel *pgs)
{
	return 0;
}

static int mdt_hsm_agent_register_mask(struct mdt_thread_info *info,
				       struct obd_uuid *uuid,
				       __u32 archive_mask)
{
	return 0;
}

static int mdt_hsm_agent_unregister(struct mdt_thread_info *info,
				    struct obd_uuid *uuid)
{
	return 0;
}

static int mdt_hsm_coordinator_get_actions(struct mdt_thread_info *mti,
					   struct hsm_action_list *hal)
{
	return 0;
}

static int mdt_hsm_coordinator_actions(struct mdt_thread_info *info,
				       struct hsm_action_list *hal,
				       __u64 *compound_id,
				       int mti_attr_is_valid)
{
	return 0;
}

/**
 * Update on-disk HSM attributes.
 */
int mdt_hsm_attr_set(struct mdt_thread_info *info, struct mdt_object *obj,
		     struct md_hsm *mh)
{
	struct md_object	*next = mdt_object_child(obj);
	struct lu_buf		*buf = &info->mti_buf;
	struct hsm_attrs	*attrs;
	int			 rc;
	ENTRY;

	attrs = (struct hsm_attrs *)info->mti_xattr_buf;
	CLASSERT(sizeof(info->mti_xattr_buf) >= sizeof(*attrs));

	/* pack HSM attributes */
	lustre_hsm2buf(info->mti_xattr_buf, mh);

	/* update SOM attributes */
	buf->lb_buf = attrs;
	buf->lb_len = sizeof(*attrs);
	rc = mo_xattr_set(info->mti_env, next, buf, XATTR_NAME_HSM, 0);

	RETURN(rc);
}

/**
 * Extract information coming from a copytool and asks coordinator to update
 * a request status depending on the update content.
 *
 * Copytools could use this to report failure in their process.
 *
 * This is HSM_PROGRESS RPC handler.
 */
int mdt_hsm_progress(struct mdt_thread_info *info)
{
	struct mdt_body			*body;
	struct hsm_progress_kernel	*hpk;
	int				 rc;
	ENTRY;

	body = req_capsule_client_get(info->mti_pill, &RMF_MDT_BODY);
	if (body == NULL)
		RETURN(-EPROTO);

	hpk = req_capsule_client_get(info->mti_pill, &RMF_MDS_HSM_PROGRESS);
	if (hpk == NULL)
		RETURN(-EPROTO);

	CDEBUG(D_HSM, "Progress on "DFID": len="LPU64" err=%d\n",
	       PFID(&hpk->hpk_fid), hpk->hpk_extent.length, hpk->hpk_errval);

	if (hpk->hpk_errval)
		CDEBUG(D_HSM, "Copytool progress on "DFID" failed (%d); %s.\n",
		       PFID(&hpk->hpk_fid), hpk->hpk_errval,
		       hpk->hpk_flags & HP_FLAG_RETRY ? "will retry" : "fatal");

	if (hpk->hpk_flags & HP_FLAG_COMPLETED)
		CDEBUG(D_HSM, "Finished "DFID" (%d) cancel cookie="LPX64"\n",
		       PFID(&hpk->hpk_fid), hpk->hpk_errval, hpk->hpk_cookie);

	rc = mdt_hsm_coordinator_update(info, hpk);

	RETURN(rc);
}

int mdt_hsm_ct_register(struct mdt_thread_info *info)
{
	struct mdt_body		*body;
	struct ptlrpc_request	*req = mdt_info_req(info);
	__u32			*archives;
	int			 rc;
	ENTRY;

	body = req_capsule_client_get(info->mti_pill, &RMF_MDT_BODY);
	if (body == NULL)
		RETURN(-EPROTO);

	archives = req_capsule_client_get(info->mti_pill, &RMF_MDS_HSM_ARCHIVE);
	if (archives == NULL)
		RETURN(-EPROTO);

	/* XXX: directly include this function here? */
	rc = mdt_hsm_agent_register_mask(info, &req->rq_export->exp_client_uuid,
					 *archives);

	RETURN(rc);
}

int mdt_hsm_ct_unregister(struct mdt_thread_info *info)
{
	struct mdt_body		*body;
	struct ptlrpc_request	*req = mdt_info_req(info);
	int			 rc;
	ENTRY;

	body = req_capsule_client_get(info->mti_pill, &RMF_MDT_BODY);
	if (body == NULL)
		RETURN(-EPROTO);

	/* XXX: directly include this function here? */
	rc = mdt_hsm_agent_unregister(info, &req->rq_export->exp_client_uuid);

	RETURN(rc);
}

/**
 * Retrieve the current HSM flags, archive id and undergoing HSM requests for
 * the fid provided in RPC body.
 *
 * Current requests are read from coordinator states.
 *
 * This is MDS_HSM_STATE_GET RPC handler.
 */
int mdt_hsm_state_get(struct mdt_thread_info *info)
{
	struct mdt_object	*obj = info->mti_object;
	struct md_attr		*ma  = &info->mti_attr;
	struct hsm_user_state	*hus;
	struct mdt_lock_handle	*lh;
	int			 rc;
	ENTRY;

	lh = &info->mti_lh[MDT_LH_CHILD];
	mdt_lock_reg_init(lh, LCK_PR);
	rc = mdt_object_lock(info, obj, lh, MDS_INODELOCK_LOOKUP,
			     MDT_LOCAL_LOCK);
	if (rc)
		RETURN(rc);

	/* Only valid if client is remote */
	rc = mdt_init_ucred(info, (struct mdt_body *)info->mti_body);
	if (rc)
		GOTO(out_unlock, rc = err_serious(rc));

	ma->ma_valid = 0;
	ma->ma_need = MA_HSM;
	rc = mdt_attr_get_complex(info, obj, ma);
	if (rc)
		GOTO(out_ucred, rc);

	if (req_capsule_get_size(info->mti_pill, &RMF_CAPA1, RCL_CLIENT))
		mdt_set_capainfo(info, 0, &info->mti_body->fid1,
			    req_capsule_client_get(info->mti_pill, &RMF_CAPA1));

	hus = req_capsule_server_get(info->mti_pill, &RMF_HSM_USER_STATE);
	if (hus == NULL)
		GOTO(out_ucred, rc = -EPROTO);

	/* Current HSM flags */
	hus->hus_states = ma->ma_hsm.mh_flags;
	hus->hus_archive_id = ma->ma_hsm.mh_arch_id;

	EXIT;
out_ucred:
	mdt_exit_ucred(info);
out_unlock:
	mdt_object_unlock(info, obj, lh, 1);
	return rc;
}

/**
 * Change HSM state and archive number of a file.
 *
 * Archive number is changed iif the value is not 0.
 * The new flagset that will be computed should result in a coherent state.
 * This function checks that are flags are compatible.
 *
 * This is MDS_HSM_STATE_SET RPC handler.
 */
int mdt_hsm_state_set(struct mdt_thread_info *info)
{
	struct mdt_object	*obj = info->mti_object;
	struct md_attr          *ma = &info->mti_attr;
	struct hsm_state_set	*hss;
	struct mdt_lock_handle	*lh;
	int			 rc;
	__u64			 flags;
	ENTRY;

	lh = &info->mti_lh[MDT_LH_CHILD];
	mdt_lock_reg_init(lh, LCK_PW);
	rc = mdt_object_lock(info, obj, lh, MDS_INODELOCK_LOOKUP,
			     MDT_LOCAL_LOCK);
	if (rc)
		RETURN(rc);

	/* Only valid if client is remote */
	rc = mdt_init_ucred(info, (struct mdt_body *)info->mti_body);
	if (rc)
		GOTO(out_obj, rc = err_serious(rc));

	/* Read current HSM info */
	ma->ma_valid = 0;
	ma->ma_need = MA_HSM;
	rc = mdt_attr_get_complex(info, obj, ma);
	if (rc)
		GOTO(out_ucred, rc);

	hss = req_capsule_client_get(info->mti_pill, &RMF_HSM_STATE_SET);
	if (hss == NULL)
		GOTO(out_ucred, rc = -EPROTO);

	if (req_capsule_get_size(info->mti_pill, &RMF_CAPA1, RCL_CLIENT))
		mdt_set_capainfo(info, 0, &info->mti_body->fid1,
			    req_capsule_client_get(info->mti_pill, &RMF_CAPA1));

	/* Change HSM flags depending on provided masks */
	if (hss->hss_valid & HSS_SETMASK)
		ma->ma_hsm.mh_flags |= hss->hss_setmask;
	if (hss->hss_valid & HSS_CLEARMASK)
		ma->ma_hsm.mh_flags &= ~hss->hss_clearmask;

	/* Change archive_id if provided. */
	if (hss->hss_valid & HSS_ARCHIVE_ID) {
		if (!(ma->ma_hsm.mh_flags & HS_EXISTS)) {
			CDEBUG(D_HSM, "Could not set an archive number for "
			       DFID "if HSM EXISTS flag is not set.\n",
			       PFID(&info->mti_body->fid1));
			GOTO(out_ucred, rc);
		}
		ma->ma_hsm.mh_arch_id = hss->hss_archive_id;
	}

	/* Check for inconsistant HSM flagset.
	 * DIRTY without EXISTS: no dirty if no archive was created.
	 * DIRTY and RELEASED: a dirty file could not be released.
	 * RELEASED without ARCHIVED: do not release a non-archived file.
	 * LOST without ARCHIVED: cannot lost a non-archived file.
	 */
	flags = ma->ma_hsm.mh_flags;
	if (((flags & HS_DIRTY) && !(flags & HS_EXISTS)) ||
	    ((flags & HS_RELEASED) && (flags & HS_DIRTY)) ||
	    ((flags & HS_RELEASED) && !(flags & HS_ARCHIVED)) ||
	    ((flags & HS_LOST)     && !(flags & HS_ARCHIVED))) {
		CDEBUG(D_HSM, "Incompatible flag change on "DFID
			      "flags="LPX64"\n",
		       PFID(&info->mti_body->fid1), flags);
		GOTO(out_ucred, rc = -EINVAL);
	}

	/* Save the modified flags */
	rc = mdt_hsm_attr_set(info, obj, &ma->ma_hsm);
	if (rc)
		GOTO(out_ucred, rc);

	EXIT;

out_ucred:
	mdt_exit_ucred(info);
out_obj:
	mdt_object_unlock(info, obj, lh, 1);
	return rc;
}

/**
 * Retrieve undergoing HSM requests for the fid provided in RPC body.
 * Current requests are read from coordinator states.
 *
 * This is MDS_HSM_ACTION RPC handler.
 */
int mdt_hsm_action(struct mdt_thread_info *info)
{
	struct hsm_current_action	*hca;
	struct hsm_action_list		*hal = NULL;
	struct hsm_action_item		*hai;
	int				 hal_size;
	int				 rc;
	ENTRY;

	/* Only valid if client is remote */
	rc = mdt_init_ucred(info, (struct mdt_body *)info->mti_body);
	if (rc)
		RETURN(rc = err_serious(rc));

	if (req_capsule_get_size(info->mti_pill, &RMF_CAPA1, RCL_CLIENT))
		mdt_set_capainfo(info, 0, &info->mti_body->fid1,
				 req_capsule_client_get(info->mti_pill,
							&RMF_CAPA1));

	hca = req_capsule_server_get(info->mti_pill,
				     &RMF_MDS_HSM_CURRENT_ACTION);
	if (hca == NULL)
		GOTO(out_ucred, rc = -EPROTO);

	/* Coordinator information */
	hal_size = sizeof(*hal) +
		   cfs_size_round(MTI_NAME_MAXLEN) /* fsname */ +
		   cfs_size_round(sizeof(*hai));

	MDT_HSM_ALLOC(hal, hal_size);
	if (hal == NULL)
		GOTO(out_ucred, rc = -ENOMEM);

	hal->hal_version = HAL_VERSION;
	hal->hal_archive_id = 0;
	hal->hal_flags = 0;
	obd_uuid2fsname(hal->hal_fsname, mdt_obd_name(info->mti_mdt),
			MTI_NAME_MAXLEN);
	hal->hal_count = 1;
	hai = hai_zero(hal);
	hai->hai_action = HSMA_NONE;
	hai->hai_cookie = 0;
	hai->hai_gid = 0;
	hai->hai_fid = info->mti_body->fid1;
	hai->hai_len = sizeof(*hai);

	rc = mdt_hsm_coordinator_get_actions(info, hal);
	if (rc)
		GOTO(out_free, rc);

	/* cookie is used to give back request status */
	if (hai->hai_cookie == 0)
		hca->hca_state = HPS_WAITING;
	else
		hca->hca_state = HPS_RUNNING;

	switch (hai->hai_action) {
	case HSMA_NONE:
		hca->hca_action = HUA_NONE;
		break;
	case HSMA_ARCHIVE:
		hca->hca_action = HUA_ARCHIVE;
		break;
	case HSMA_RESTORE:
		hca->hca_action = HUA_RESTORE;
		break;
	case HSMA_REMOVE:
		hca->hca_action = HUA_REMOVE;
		break;
	case HSMA_CANCEL:
		hca->hca_action = HUA_CANCEL;
		break;
	default:
		hca->hca_action = HUA_NONE;
		CERROR("%s: Unknown hsm action: %d on "DFID"\n",
		       mdt_obd_name(info->mti_mdt),
		       hai->hai_action, PFID(&hai->hai_fid));
		break;
	}

	hca->hca_location = hai->hai_extent;

	EXIT;
out_free:
	MDT_HSM_FREE(hal, hal_size);
out_ucred:
	mdt_exit_ucred(info);
	return rc;
}

/**
 * Process the HSM actions described in a struct hsm_user_request.
 *
 * The action described in hur will be send to coordinator to be saved and
 * processed later or either handled directly if hur.hur_action is HUA_RELEASE.
 *
 * This is MDS_HSM_REQUEST RPC handler.
 */
int mdt_hsm_request(struct mdt_thread_info *info)
{
	struct req_capsule		*pill = info->mti_pill;
	struct mdt_body			*body;
	struct hsm_request		*hr;
	struct hsm_user_item		*hui;
	struct hsm_action_list		*hal;
	struct hsm_action_item		*hai;
	const void			*data;
	int				 hui_list_size;
	int				 data_size;
	enum hsm_copytool_action	 action = HSMA_NONE;
	__u64				 compound_id;
	int				 hal_size, i, rc;
	ENTRY;

	body = req_capsule_client_get(pill, &RMF_MDT_BODY);
	hr = req_capsule_client_get(pill, &RMF_MDS_HSM_REQUEST);
	hui = req_capsule_client_get(pill, &RMF_MDS_HSM_USER_ITEM);
	data = req_capsule_client_get(pill, &RMF_GENERIC_DATA);

	if (body == NULL || hr == NULL || hui == NULL || data == NULL)
		RETURN(-EPROTO);

	/* Sanity check. Nothing to do with an empty list */
	if (hr->hr_itemcount == 0)
		RETURN(0);

	hui_list_size = req_capsule_get_size(pill, &RMF_MDS_HSM_USER_ITEM,
					     RCL_CLIENT);
	if (hui_list_size < hr->hr_itemcount * sizeof(*hui))
		RETURN(-EPROTO);

	data_size = req_capsule_get_size(pill, &RMF_GENERIC_DATA, RCL_CLIENT);
	if (data_size != hr->hr_data_len)
		RETURN(-EPROTO);

	/* Only valid if client is remote */
	rc = mdt_init_ucred(info, body);
	if (rc)
		RETURN(err_serious(rc));

	switch (hr->hr_action) {
	/* code to be removed in hsm1_merge and final patch */
	case HUA_RELEASE:
		CERROR("Release action is not working in hsm1_coord\n");
		GOTO(out_ucred, rc = -EINVAL);
		break;
	/* end of code to be removed */
	case HUA_ARCHIVE:
		action = HSMA_ARCHIVE;
		break;
	case HUA_RESTORE:
		action = HSMA_RESTORE;
		break;
	case HUA_REMOVE:
		action = HSMA_REMOVE;
		break;
	case HUA_CANCEL:
		action = HSMA_CANCEL;
		break;
	default:
		CERROR("Unknown hsm action: %d\n", hr->hr_action);
		GOTO(out_ucred, rc = -EINVAL);
	}

	hal_size = sizeof(*hal) + cfs_size_round(MTI_NAME_MAXLEN) /* fsname */ +
		   (sizeof(*hai) + cfs_size_round(hr->hr_data_len)) *
		   hr->hr_itemcount;

	MDT_HSM_ALLOC(hal, hal_size);
	if (hal == NULL)
		GOTO(out_ucred, rc = -ENOMEM);

	hal->hal_version = HAL_VERSION;
	hal->hal_archive_id = hr->hr_archive_id;
	hal->hal_flags = hr->hr_flags;
	obd_uuid2fsname(hal->hal_fsname, mdt_obd_name(info->mti_mdt),
			MTI_NAME_MAXLEN);

	hal->hal_count = hr->hr_itemcount;
	hai = hai_zero(hal);
	for (i = 0; i < hr->hr_itemcount; i++) {
		hai->hai_action = action;
		hai->hai_cookie = 0;
		hai->hai_gid = 0;
		hai->hai_fid = hui[i].hui_fid;
		hai->hai_extent = hui[i].hui_extent;
		memcpy(hai->hai_data, data, hr->hr_data_len);
		hai->hai_len = sizeof(*hai) + hr->hr_data_len;
		hai = hai_next(hai);
	}

	rc = mdt_hsm_coordinator_actions(info, hal, &compound_id, 0);
	/* ENODATA error code is needed only for implicit requests */
	if (rc == -ENODATA)
		rc = 0;

	MDT_HSM_FREE(hal, hal_size);
	EXIT;
out_ucred:
	mdt_exit_ucred(info);
	return rc;
}
