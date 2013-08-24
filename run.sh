#!/bin/bash
CFG=${CFG:-}

if [ "$CFG" != "" ]; then
    wget $CFG -O /opt/logstash.conf --no-check-certificate
fi

supervisord -c /etc/supervisor/supervisor.conf -n
