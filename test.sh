#!/usr/bin/env bash

EXIT_STATUS=0
if [ "$(cat data.txt)" -gt "7" ]; then 
    echo "fail" 
    EXIT_STATUS=1
fi
exit $EXIT_STATUS
