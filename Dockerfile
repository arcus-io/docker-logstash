FROM debian:jessie
MAINTAINER Arcus "http://arcus.io"
RUN apt-get update
RUN apt-get install -y wget openjdk-7-jre-headless
RUN wget https://download.elasticsearch.org/logstash/logstash/logstash-1.4.2.tar.gz -O /tmp/logstash.tar.gz && \
    (cd /tmp && tar zxf logstash.tar.gz && mv logstash-1.4.2 /opt/logstash && \
    rm logstash.tar.gz)
ADD run.sh /usr/local/bin/run
RUN chmod +x /usr/local/bin/run

EXPOSE 514 514/udp 9200 9292 9300
CMD ["/usr/local/bin/run"]
