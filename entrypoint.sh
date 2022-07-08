#!/bin/sh

set -e

if [ -z "$HEALTHCHECK_URL" ]
then
    echo "WARNING: HEALTHCHECK_URL is not defined, exiting"
    exit 1
else
    echo "Running scheduled healthcheck"
    while [ true ]
    do
    echo "$(date -Is): Status: $(curl -s $HEALTHCHECK_URL)"
    sleep $HEALTHCHECK_FREQUENCY
    done
fi
