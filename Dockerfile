FROM base
MAINTAINER Arcus "http://arcus.io"
RUN echo "deb http://archive.ubuntu.com/ubuntu quantal main universe multiverse" > /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -y make wget build-essential openjdk-6-jre ruby ruby-dev rubygems supervisor
RUN wget http://logstash.objects.dreamhost.com/release/logstash-1.1.13-flatjar.jar -O /opt/logstash.jar --no-check-certificate
RUN (cd /tmp && wget https://github.com/rashidkpc/Kibana/archive/v0.2.0.tar.gz -O pkg.tar.gz --no-check-certificate && tar zxf pkg.tar.gz && mv Kibana-* /opt/kibana)
RUN (cd /opt/kibana && gem install --no-ri --no-rdoc bundler && bundle install)
RUN (cd /opt/kibana && sed -i 's/.*KibanaHost =.*/  KibanaHost = \"0\.0\.0\.0\"/g' KibanaConfig.rb)
ADD logstash.conf /opt/logstash.conf
ADD supervisor.conf /etc/supervisor/supervisor.conf
ADD run.sh /usr/local/bin/run
RUN chmod +x /usr/local/bin/run
RUN rm -rf /tmp/*

EXPOSE 514
EXPOSE 5601
EXPOSE 9200
EXPOSE 9300
EXPOSE 9292
CMD ["/usr/local/bin/run"]
