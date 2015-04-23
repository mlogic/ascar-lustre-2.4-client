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

TESTDIR=$MOUNT/d0.tar-$(hostname)

do_tar() {
    tar cf - /etc | tar xf - >$LOG 2>&1
    return ${PIPESTATUS[1]}
}

CONTINUE=true
while [ ! -e "$END_RUN_FILE" ] && $CONTINUE; do
    echoerr "$(date +'%F %H:%M:%S'): tar run starting"
    mkdir -p $TESTDIR
    cd $TESTDIR
    do_tar &
    wait $!
    RC=$?
    PREV_ERRORS=$(grep "exit delayed from previous errors" $LOG) || true
    if [ $RC -ne 0 -a "$ERRORS_OK" -a "$PREV_ERRORS" ]; then
        echoerr "$(date +'%F %H:%M:%S'): tar errors earlier, ignoring"
        RC=0
    fi
    if [ $RC -eq 0 ]; then
        echoerr "$(date +'%F %H:%M:%S'): tar succeeded"
        cd $TMP
        rm -rf $TESTDIR
        echoerr "$(date +'%F %H:%M:%S'): tar run finished"
    else
        echoerr "$(date +'%F %H:%M:%S'): tar failed"
        if [ -z "$ERRORS_OK" ]; then
            echo $(hostname) >> $END_RUN_FILE
        fi
        if [ $BREAK_ON_ERROR ]; then
            # break
            CONTINUE=false
        fi
    fi
done

echoerr "$(date +'%F %H:%M:%S'): tar run exiting"
