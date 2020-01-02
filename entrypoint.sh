#!/bin/sh

/usr/bin/gen-sh-unittest
EXITCODE="$?"
[ "$EXITCODE" = 0 ] && RESULT=OK || RESULT=ERROR
echo ::set-output name=result::$RESULT
exit "$EXITCODE"
