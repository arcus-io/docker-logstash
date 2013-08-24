# Logstash

Logstash 1.1.13 & Kibana 0.2.0

Uses supervisor for managing logstash and kibana

* `docker build -t logstash .`
* `docker run logstash`

Ports

* 514 (syslog)
* 5601 (kibana)
* 9200 (elasticsearch)
* 9292 (logstash ui)
* 9300 (elasticsearch)
