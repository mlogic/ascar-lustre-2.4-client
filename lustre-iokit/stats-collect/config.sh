#
# system configuration.  Set these variables to point to the locations
# of various system utilities.
#
AWK=/usr/bin/awk
XARGS=/usr/bin/xargs

#
# control debug output.  set PRINT_INFO_MSGS=1 to see additional messages
#   set PRINT_DEBUG_MSGS=1 to see debug messages
#
PRINT_INFO_MSGS=0
PRINT_DEBUG_MSGS=0

#
# TARGETS: set this variable to the list of nodes you want to
# gather stats from
#
# Example:
#
PERCH_MDS_LIST="nid00135"
PERCH_OST_LIST="nid00128 nid00131 nid00136 nid00139 nid00008 nid00011 nid00012"

MDS_LIST=${PERCH_MDS_LIST}
OST_LIST=${PERCH_OST_LIST}
export TARGETS="${MDS_LIST} ${OST_LIST}" 

#script var 
#case $TARGET in
#	oss*)     
#		VMSTAT_INTERVAL=0 
#		SERVICE_INTERVAL=2 
#		SDIO_INTERVAL=0  
#	;;
#	client*)  ALEX_SCRIPT_CLIENT_VAR1="hello!"
#	;;
#esac

#FIXME: diff these parameters according to client/MDS/OSS 
VMSTAT_INTERVAL=${VMSTAT_INTERVAL:-1} 
SERVICE_INTERVAL=${SERVICE_INTERVAL:-0}
SDIO_INTERVAL=${SDIO_INTERVAL:-0}
BRW_INTERVAL=${BRW_INTERVAL:-0}
MBALLOC_INTERVAL=${MBALLOC_INTERVAL:-0}
IO_INTERVAL=${IO_INTERVAL:-1}
JBD_INTERVAL=${JBD_INTERVAL:-1}

#some environment var
TMP=${TMP:-"/tmp"}
SCRIPT=${SCRIPT:-"lstats.sh"}
#Remote ssh script
DSH=${DSH:-ssh}
DCP=${DCP:-scp}
USER=""
TAR=${TAR:-tar -zcvf}

