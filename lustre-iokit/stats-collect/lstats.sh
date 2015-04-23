#!/bin/sh

#
# very short example:
#
# to start collection:
#   VMSTAT_INTERVAL=0 SERVICE_INTERVAL=2 SDIO_INTERVAL=0 lstats.sh start
#
# where value of interval means:
#   0 - gather stats at start and stop only
#   N - gather stats every N seconds
# if some XXX_INTERVAL isn't specified, related stats won't be collected
# XXX can be: VMSTAT, SERVICE, BRW, SDIO, MBALLOC, IO, JBD
#
# to stop collection:
#   lstats.sh stop
#
# to fetch collected stats:
#   lstats.sh fetch >file
# in file you'll get a tarbal containing directory with stats
# directory's name consists of hostname and date,
# like: stats-bzzz-2007-05-13-22.52.31
#

#
# TODO
#  - close all file descriptors, otherwise sshd can't finish session
#  - for sd_iostats convert partition to whole device
#

# configuration variables
TMP=${TMP:-/tmp}
PREFIX=${PREFIX:-${TMP}/lstats.}
PIDFILE=${PREFIX}pid
STATPIDS=${PREFIX}pids
OUTPREFIX=${OUTPREFIX:-${PREFIX}out.}
STIMEPREFIX=${STIMEPREFIX:-${PREFIX}time.}


function ls_grab_control()
{
	OCOMM=`ps -p $$ -o comm=`
	if [ "$OCOMM" == "" ]; then
		echo "Can't fetch process name"
		exit
	fi

	# check for running master first
	PID=`cat $PIDFILE 2>/dev/null`
#echo "check master $PID"
	if [ "x$PID" != "x" ]; then
		COMM=`ps -p $PID -o comm=`
		if [ "$COMM" == "$OCOMM" ]; then
			echo "Master is already running by $PID"
			return 1
		fi
	fi

	# XXX: race -- two process can do this at same time, use rename instead
	echo $$ >${PIDFILE}.$$
	mv ${PIDFILE}.$$ ${PIDFILE}
	a=`cat ${PIDFILE}`
	if [ "$$" != "$a" ]; then
		echo "Some one $a won the race"
		return 1
	fi

	HAS_CONTROL="yes"
#echo "We've got control"

	return 0

}

function ls_release_control()
{
#echo "Release control"

	rm -f $PIDFILE
}

trap ls_atexit EXIT
function ls_atexit()
{
	if [ "$HAS_CONTROL" != "" ]; then
		ls_release_control
	fi
}


function usr1signal()
{
	stop_collector=1
}

function idle_collector()
{
	while [ "$stop_collector" != "1" ]; do
		sleep 100;
	done
}

#
# args:
# - type
# - collector function
# - collector arguments
function run_collector()
{
	local pid
	local stime
	local ctype=$1
	local cfunc=$2
	shift
	shift

	read pid NN </proc/self/stat
	stime=`ps -p $pid -o bsdstart=`
	echo -n "$pid " >>$STATPIDS
	echo -n "$stime" >>${STIMEPREFIX}${pid}

	trap "usr1signal" SIGUSR1

#	echo "$pid: new collector $ctype $cfunc"
	$cfunc $@ </dev/null >&${OUTPREFIX}${ctype}.${pid}

}

#
# vmstat collector
#
# VMSTAT_INTERVAL:
# - 0       - collect at start and stop only
# - N       - collect each N seconds
function vmstat_collector()
{
	echo "vmstat " `date`

	if let "VMSTAT_INTERVAL==0"; then
		date
		vmstat
		idle_collector
		date
		vmstat
	elif let "VMSTAT_INTERVAL>0"; then
		vmstat $VMSTAT_INTERVAL
	else
		echo "Invalid VMSTAT_INTERVAL=$VMSTAT_INTERVAL"
		idle_collector
	fi
}

function vmstat_start()
{
	if [ "$VMSTAT_INTERVAL" == "" ]; then
		return;
	fi

	run_collector "vmstat" vmstat_collector &
}

#
# brw_stats collector
#
# BRW_INVERVAL:
# - 0 - collect at start and stop only
# - N - collect each N seconds
#
function brw_collector()
{
	local filter=$1

	echo "brw_* for $filter " `date`

	# clear old stats
	for i in /proc/fs/lustre/obdfilter/${filter}/brw_*; do
		echo 0 >$i
	done

	if let "BRW_INTERVAL==0"; then
		cat /proc/fs/lustre/obdfilter/${filter}/brw_*
		idle_collector
		cat /proc/fs/lustre/obdfilter/${filter}/brw_*
	elif let "BRW_INTERVAL>0"; then
		while [ "$stop_collector" != "1" ]; do
			cat /proc/fs/lustre/obdfilter/${filter}/brw_*
			sleep $BRW_INTERVAL
		done
	else
		echo "Invalid BRW_INTERVAL=$BRW_INTERVAL"
		idle_collector
	fi
}

function brw_start()
{
	if [ "$BRW_INTERVAL" == "" ]; then
		return;
	fi

	# find all obdfilters
	for i in /proc/fs/lustre/obdfilter/*; do
		filter=`basename $i`
		if [ "$filter" == "num_refs" ]; then
			continue;
		fi
		run_collector "brw" brw_collector $filter &
	done
}

#
# service_stats collector
#
# SERVICE_INVERVAL:
# - 0 - collect at start and stop only
# - N - collect each N seconds
#
function service_collector()
{
	local file=$1
	local target=$2
	local srv=$3

	echo "service stats for ${target}/${srv} " `date`

	# clear old stats
	echo 0 >$file

	if let "SERVICE_INTERVAL==0"; then
		grep -v "^[^ ]*[^0-9]*0 samples" $file
		idle_collector
		grep -v "^[^ ]*[^0-9]*0 samples" $file
	elif let "SERVICE_INTERVAL>0"; then
		while [ "$stop_collector" != "1" ]; do
			grep -v "^[^ ]*[^0-9]*0 samples" $file
			sleep $SERVICE_INTERVAL
		done
	else
		echo "Invalid SERVICE_INTERVAL=$SERVICE_INTERVAL"
		idle_collector
	fi
}

function service_start()
{
	if [ "$SERVICE_INTERVAL" == "" ]; then
		return;
	fi

	# find all OSTs and MDTs
	for i in /proc/fs/lustre/ost/* /proc/fs/lustre/mdt/*; do
		target=`basename $i`
		if [ "$target" == "num_refs" ]; then
			continue;
		fi
		for j in ${i}/*; do
			srv=`basename $j`
			if [ "$srv" == "uuid" ]; then
				continue;
			fi
			run_collector "service-${srv}" service_collector \
				${j}/stats $target $srv &
		done
	done

	# find all LDLM services
	for i in /proc/fs/lustre/ldlm/services/*; do
		srv=`basename $i`
		run_collector "service" service_collector ${i}/stats "ldlm" $srv &
	done

}

#
# client_stats collector
#
# CLIENT_INTERVAL:
# - 0 - collect at start and stop only
# - N - collect each N seconds
#
function client_collector()
{
	local file=$1
	local target=$2
	local srv=$3

	echo "client stats for ${target}/${srv} " `date`

	# clear old stats
	echo 0 >$file

	if let "CLIENT_INTERVAL==0"; then
		grep -v "^[^ ]*[^0-9]*0 samples" $file
		idle_collector
		grep -v "^[^ ]*[^0-9]*0 samples" $file
	elif let "CLIENT_INTERVAL>0"; then
		while [ "$stop_collector" != "1" ]; do
			grep -v "^[^ ]*[^0-9]*0 samples" $file
			sleep $CLIENT_INTERVAL
		done
	else
		echo "Invalid CLIENT_INTERVAL=$CLIENT_INTERVAL"
		idle_collector
	fi
}

function client_start()
{
	if [ "$CLIENT_INTERVAL" == "" ]; then
		return;
	fi

	# find all osc 
	for i in /proc/fs/lustre/osc/* ; do
		target=`basename $i`
		if [ "$target" == "num_refs" ]; then
			continue;
		fi
		for j in ${i}/*; do
			stats=`basename $j`
			if [ "$stats" == "stats" -o "$stats" == "rpc_stats" ]; then
				run_collector "osc-${stats}" client_collector \
					${j} $target $stats &
			fi
		done
	done
	# find all llite stats
	for i in /proc/fs/lustre/llite/* ; do
		target=`basename $i`
		for j in ${i}/*; do
			stats=`basename $j`
			if [ "$stats" == "stats" -o "$stats" == "vfs_ops_stats" ]; then
				run_collector "llite-${stats}" client_collector \
					${j} $target ${stats} &
			fi
		done
	done
}

#
# sdio_stats collector
#
# SDIO_INVERVAL:
# - 0 - collect at start and stop only
# - N - collect each N seconds
#
function sdio_collector()
{
	local obd=$1
	local uuid=`cat $obd/uuid`
	local tmp=`cat $obd/mntdev`
	local disk=`basename $tmp`
	local file="/proc/scsi/sd_iostats/${disk}"

	echo "sd_iostats for ${uuid}/${disk} " `date`

	# clear old stats
	echo 0 >$file

	if let "SDIO_INTERVAL==0"; then
		cat $file
		idle_collector
		cat $file
	elif let "SDIO_INTERVAL>0"; then
		while [ "$stop_collector" != "1" ]; do
			cat $file
			sleep $SDIO_INTERVAL
		done
	else
		echo "Invalid SDIO_INTERVAL=$SDIO_INTERVAL"
		idle_collector
	fi
}

function sdio_start()
{
	if [ "$SDIO_INTERVAL" == "" ]; then
		return;
	fi

	# find all obdfilters and MDSs
	for i in /proc/fs/lustre/obdfilter/* /proc/fs/lustre/mds/*; do
		obd=`basename $i`
		if [ "$obd" == "num_refs" ]; then
			continue;
		fi
		if [ ! -f ${i}/mntdev ]; then
			continue;
		fi
		tmp=`cat ${i}/mntdev`
		disk=`basename $tmp`
		if [ ! -f /proc/scsi/sd_iostats/${disk} ]; then
			continue;
		fi
		run_collector "sdio" sdio_collector ${i} &
	done
}

#
# mballoc_stats collector
#
# MBALLOC_INVERVAL:
# - 0 - collect at start and stop only
# - N - isn't implemented yet, works as with 0
#
function mballoc_collector()
{
	local obd=$1
	local uuid=`cat $obd/uuid`
	local tmp=`cat $obd/mntdev`
	local disk=`basename $tmp`
	local file="/proc/fs/ldiskfs*/${disk}/mb_history"

	echo "mballoc history for ${uuid}/${disk} " `date`

	# log allocations only
	for i in $file; do
		echo 3 >$i
	done

	if let "MBALLOC_INTERVAL==0"; then
		idle_collector
		cat $file
	elif let "MBALLOC_INTERVAL>0"; then
		idle_collector
		cat $file
	else
		echo "Invalid MBALLOC_INTERVAL=$MBALLOC_INTERVAL"
		idle_collector
	fi
}

function mballoc_start()
{
	if [ "$MBALLOC_INTERVAL" == "" ]; then
		return;
	fi

	# find all obdfilters and MDSs
	for i in /proc/fs/lustre/obdfilter/* /proc/fs/lustre/mds/*; do
		obd=`basename $i`
		if [ "$obd" == "num_refs" ]; then
			continue;
		fi
		if [ ! -f ${i}/mntdev ]; then
			continue;
		fi
		tmp=`cat ${i}/mntdev`
		disk=`basename $tmp`
		if [ ! -f /proc/fs/ldiskfs*/${disk}/mb_history ]; then
			continue;
		fi
		run_collector "mballoc" mballoc_collector ${i} &
	done
}

#
# io_stats collector
#
# IO_INVERVAL:
# - 0 - collect at start and stop only
# - N - collect each N seconds
#
function io_collector()
{
	local obd=$1
	local uuid=`cat $obd/uuid`
	local tmp=`cat $obd/mntdev`
	local disk=`basename $tmp`
	local file="/sys/block/${disk}/stat"

	echo "iostats for ${uuid}/${disk} " `date`

	if let "IO_INTERVAL==0"; then
		cat $file
		idle_collector
		cat $file
	elif let "IO_INTERVAL>0"; then
		while [ "$stop_collector" != "1" ]; do
			cat $file
			sleep $IO_INTERVAL
		done
	else
		echo "Invalid IO_INTERVAL=$IO_INTERVAL"
		idle_collector
	fi
}

function io_start()
{
	if [ "$IO_INTERVAL" == "" ]; then
		return;
	fi

	# find all obdfilters and MDSs
	for i in /proc/fs/lustre/obdfilter/* /proc/fs/lustre/mds/*; do
		obd=`basename $i`
		if [ "$obd" == "num_refs" ]; then
			continue;
		fi
		if [ ! -f ${i}/mntdev ]; then
			continue;
		fi
		tmp=`cat ${i}/mntdev`
		disk=`basename $tmp`
		if [ ! -f /sys/block/${disk}/stat ]; then
			continue;
		fi
		run_collector "io" io_collector ${i} &
	done
}

#
# jbd_stats collector
#
# JBD_INVERVAL:
# - 0 - collect at start and stop only
# - N - isn't implemented yet, works as with 0
#
function jbd_collector()
{
	local obd=$1
	local uuid=`cat $obd/uuid`
	local tmp=`cat $obd/mntdev`
	local disk=`basename $tmp`
	local file="/proc/fs/jbd/${disk}/history"

	echo "jbd history for ${uuid}/${disk} " `date`

	if let "JBD_INTERVAL==0"; then
		idle_collector
		cat $file
	elif let "JBD_INTERVAL>0"; then
		idle_collector
		cat $file
	else
		echo "Invalid JBD_INTERVAL=$JBD_INTERVAL"
		idle_collector
	fi
}

function jbd_start()
{
	if [ "$JBD_INTERVAL" == "" ]; then
		return;
	fi

	# find all obdfilters and MDSs
	for i in /proc/fs/lustre/obdfilter/* /proc/fs/lustre/mds/*; do
		obd=`basename $i`
		if [ "$obd" == "num_refs" ]; then
			continue;
		fi
		if [ ! -f ${i}/mntdev ]; then
			continue;
		fi
		tmp=`cat ${i}/mntdev`
		disk=`basename $tmp`
		if [ ! -f /proc/fs/jbd/${disk}/history ]; then
			continue;
		fi
		run_collector "jbd" jbd_collector ${i} &
	done
}

#
# start entry point
#
function ls_start()
{
	if ! ls_grab_control; then
		exit
	fi

	PID=`cat $STATPIDS 2>/dev/null`
	if [ "x$PID" != "x" ]; then
		for i in $PID; do
			i=`echo $i | sed 's/^[^:]*://'`
			TO=`cat ${STIMEPREFIX}$i`
			TN=`ps -p $i -o bsdstart=`
			if [ "$TO" != "" -a "$TO" == "$TN" ]; then
				echo "Some slave is already running by $i"
				exit
			fi
		done
	fi

	# clean all all stuff
	rm -rf ${STATPIDS}* ${OUTPREFIX}* ${STIMEPREFIX}

	vmstat_start
	brw_start
	service_start
	sdio_start
	mballoc_start
	io_start
	jbd_start
	client_start
}

#
# stop entry point
#
# should stop collection, gather all collected data
#
function ls_stop()
{
	if ! ls_grab_control; then
		exit
	fi

	PID=`cat $STATPIDS 2>/dev/null`
	if [ "x$PID" != "x" ]; then
		pids2wait=""
		for i in $PID; do
			i=`echo $i | sed 's/^[^:]*://'`
			TO=`cat ${STIMEPREFIX}$i 2>/dev/null`
			TN=`ps -p $i -o bsdstart=`
			if [ "$TO" == "" -o "$TO" != "$TN" ]; then
				echo "No collector with $i found"
				continue
			fi
			/bin/kill -s USR1 -- -${i}
			pids2wait="$pids2wait $i"
		done
#echo "XXX: wait collectors $pids2wait"
		for i in $pids2wait; do
			TO=`cat ${STIMEPREFIX}$i 2>/dev/null`
			TN=`ps -p $i -o bsdstart=`
			while [ "$TO" != "" -a "$TO" == "$TN" ]; do
				sleep 1
				TN=`ps -p $i -o bsdstart=`
			done
		done
	fi
	rm -f $STATPIDS ${STIMEPREFIX}*
}

#
# fetch entry point
#
# creates tarball of all collected stats
# current version is silly - just finds all *out* files in $TMP
ls_fetch()
{
	if [ "X${GLOBAL_TIMESTAMP}" = "X" ]
	then
		local date=`date +%F-%H.%M.%S`
	else
		local date=${GLOBAL_TIMESTAMP}
	fi

	local hostname=`hostname -s`
	local name="stats-$hostname-$date"

	stats=${OUTPREFIX}*
	if ! mkdir ${TMP}/${name}; then
		echo "Can't create ${TMP}/${name}"
		exit
	fi

	let found=0
	for i in ${OUTPREFIX}*; do
		mv $i ${TMP}/${name}/
		let "found++"
	done

	if let "found > 0"; then
		(cd ${TMP}; tar -zcf "./${name}.tar.gz" "./${name}")
		cat ${TMP}/${name}.tar.gz
	else
		echo "No stats found"
	fi
	rm -rf ${TMP}/${name}*
		
}

#
# abort entry point
#
# should kill all running collections
#
function ls_abort()
{
	echo "Abort isn't implemented yet"
}

#########
#  main
#########

# required to put all background processes into different process groups
# so that we can manage whole groups sending them a single signal
set -m

case $1 in
	start) ls_start ;;
	stop)  ls_stop ;;
	fetch) ls_fetch ;;
	abort)  ls_abort ;;
	*) echo "Unknown command"
esac

