#!/bin/bash
CFG=${CFG:-}
ES_HOST=${ES_HOST:-127.0.0.1}
ES_HTTP_PORT=${ES_HTTP_PORT:-9200}
ES_PORT=${ES_PORT:-9300}
EMBEDDED="false"
ENABLE_WEB=${ENABLE_WEB:-}
LOGSTASH_ROOT=/opt/logstash

if [ "$ES_HOST" = "127.0.0.1" ] ; then
    EMBEDDED="true"
fi

if [ "$CFG" != "" ]; then
    wget $CFG -O /opt/logstash.conf --no-check-certificate
else
    cat << EOF > /opt/logstash.conf
input {
  syslog {
    type => syslog
    port => 514
  }
}
output {
  stdout { }
EOF
    if [ "$EMBEDDED" = "true" ]; then
        cat << EOF >> /opt/logstash.conf
  elasticsearch { embedded => $EMBEDDED }
}
EOF
    else
        cat << EOF >> /opt/logstash.conf
  elasticsearch { embedded => $EMBEDDED host => "$ES_HOST" port => $ES_PORT }
}
EOF
   fi
fi

# configure elasticsearch in kibana
sed -i "s/\s.elasticsearch:.*/     elasticsearch: \"http:\/\/$ES_HOST:$ES_HTTP_PORT\",/g" $LOGSTASH_ROOT/vendor/kibana/config.js
if [ ! -z "$ENABLE_WEB" ]; then
    $LOGSTASH_ROOT/bin/logstash web &
fi
$LOGSTASH_ROOT/bin/logstash agent -f /opt/logstash.conf
