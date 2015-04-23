#!/bin/bash

TMP=${TMP:-/tmp}

TESTLOG_PREFIX=${TESTLOG_PREFIX:-$TMP/recovery-mds-scale}
TESTNAME=${TESTNAME:-""}
[ -n "$TESTNAME" ] && TESTLOG_PREFIX=$TESTLOG_PREFIX.$TESTNAME

LOG=$TESTLOG_PREFIX.$(basename $0 .sh)_stdout.$(hostname -s).log
DEBUGLOG=$(echo $LOG | sed 's/\(.*\)stdout/\1debug/')

mkdir -p ${LOG%/*}

rm -f $LOG $DEBUGLOG
exec 2>$DEBUGLOG
set -x

. $(dirname $0)/functions.sh

assert_env MOUNT END_RUN_FILE LOAD_PID_FILE

trap signaled TERM

# recovery-*-scale scripts use this to signal the client loads to die
echo $$ >$LOAD_PID_FILE

TESTDIR=$MOUNT/d0.iozone-$(hostname)

CONTINUE=true
while [ ! -e "$END_RUN_FILE" ] && $CONTINUE; do
    echoerr "$(date +'%F %H:%M:%S'): iozone run starting"
    mkdir -p $TESTDIR
    cd $TESTDIR
    iozone -a -M -R -V 0xab -g 100M -q 512k -i0 -i1 -f $TESTDIR/iozone-file 1>$LOG &
    load_pid=$!
    wait $load_pid
    if [ ${PIPESTATUS[0]} -eq 0 ]; then
        echoerr "$(date +'%F %H:%M:%S'): iozone succeeded"
        cd $TMP
        rm -rf $TESTDIR
        if [ -d $TESTDIR ]; then
            echoerr "$(date +'%F %H:%M:%S'): failed to remove $TESTDIR"
            echo $(hostname) >> $END_RUN_FILE
            CONTINUE=false
        fi
        echoerr "$(date +'%F %H:%M:%S'): iozone run finished"
    else
        echoerr "$(date +'%F %H:%M:%S'): iozone failed"
        if [ -z "$ERRORS_OK" ]; then
            echo $(hostname) >> $END_RUN_FILE
        fi
        if [ $BREAK_ON_ERROR ]; then
            # break
            CONTINUE=false
        fi
    fi
done

echoerr "$(date +'%F %H:%M:%S'): iozone run exiting"
