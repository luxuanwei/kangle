FROM library/ubuntu:14.04
ENV REFRESHED_AT 2015-7-28

RUN apt-get update
RUN apt-get install make
RUN apt-get install gcc build-essential -y
RUN apt-get install libpcre3 libpcre3-dev
RUN apt-get install openssl
RUN apt-get install libssl-dev -y
RUN apt-get install sqlite -y
RUN apt-get install lib32stdc++6 -y
COPY . /usr/bin
ADD http://download.kanglesoft.com/src/kangle-3.4.2.tar.gz /
RUN tar xzf kangle-3.4.2.tar.gz
WORKDIR /kangle-3.4.2
RUN ./configure --prefix=/usr/local/kangle
RUN make && make install

CMD ["usr/bin/kangle.sh"]