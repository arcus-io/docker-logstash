# Logstash

Logstash 1.1.13


* `docker build -t logstash .`
* `docker run logstash`
 or with an external elasticsearch
* `docker run -e ES_HOST=1.2.3.4 -e ES_PORT=9300 logstash`

Ports

* 514 (syslog)
* 9200 (embedded elasticsearch if no external specified)
* 9292 (logstash ui)
* 9300 (embedded elasticsearch if no external specified)
