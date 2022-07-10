#!/bin/sh

#Health of RAID array
raid_status() { awk '/^md/ {printf "%s: ", $1}; /blocks/ {print $NF}'  /proc/mdstat | awk '/\[U+\]/ {print "\033[32m" $0 "\033[0m"}; /\[.*_.*\]/ {print "\033[31m" $0 "\033[0m"}'; }

set -e

if [ -z "$HEALTHCHECK_URL" ]
then
    echo "WARNING: HEALTHCHECK_URL is not defined, exiting"
    exit 1
else
    echo "Running scheduled mdadm healthcheck"
    while [ true ]
    do
    if grep -q '\[[^]]*_.*]' /mdstat
    then
            echo -n "RAID is failed: "
            raid_status
            curl \
                --connect-timeout $CURL_TIMEOUT \
                --max-time $CURL_MAXTIME \
                --retry $CURL_RETRIES \
                -qs $HEALTHCHECK_URL/fail
    elif grep -q '\[[^]]*U.*]' /mdstat
    then
            echo -n "RAID is OK: "
            raid_status
            curl \
                --connect-timeout $CURL_TIMEOUT \
                --max-time $CURL_MAXTIME \
                --retry $CURL_RETRIES \
                -qs $HEALTHCHECK_URL
    else
            echo "Unable to match raid status"
    fi
    sleep $HEALTHCHECK_FREQUENCY
    done
fi