FROM library/ubuntu:14.04
ENV REFRESHED_AT 2015-7-28

RUN apt-get -yqq update
RUN apt-get -yqq install tomcat7 default-jdk

ENV CATALINA_HOME /usr/share/tomcat7
ENV CATALINA_BASE /var/lib/tomcat7
ENV CATALINA_PID  /var/run/tomcat7.pid
ENV CATALINA_SH   /usr/share/tomcat7/bin/catalina.sh
ENV CATALINA_TMPDIR /tmp/tomcat7-tomcat7-tmp

RUN apt-get update
RUN apt-get install make
RUN apt-get install gcc build-essential -y
RUN apt-get install libpcre3 libpcre3-dev
RUN apt-get install openssl
RUN apt-get install libssl-dev -y
RUN apt-get install sqlite -y
RUN apt-get install lib32stdc++6 -y
COPY . /usr/bin
chmod 777 kangle.sh
ADD http://download.kanglesoft.com/src/kangle-3.4.2.tar.gz /
RUN tar xzf kangle-3.4.2.tar.gz
WORKDIR /kangle-3.4.2
RUN ./configure --prefix=/usr/local/kangle
RUN make && make install


RUN mkdir -p $CATALINA_TMPDIR
VOLUME ["/var/lib/tomcat7/webapps/"]
EXPOSE 8080 9000
ENTRYPOINT ["/usr/share/tomcat7/bin/catalina.sh", "run" ]