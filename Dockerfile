FROM ubuntu:14.04

RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential && \
  apt-get install -y software-properties-common && \
  apt-get install -y byobu curl git htop man unzip vim wget && \
  apt-get install -y autoconf && \
  rm -rf /var/lib/apt/lists/*

RUN apt-get -y install build-essential
RUN apt-get -y update
RUN apt-get -y install libssl-dev
RUN apt-get -y update
RUN apt-get -y install libdb++-dev
RUN apt-get -y install libboost-all-dev
RUN apt-get -y install libminiupnpc-dev
#RUN apt-get -y install libdb4.8-dev
RUN apt-get -y install libtool
RUN apt-get -y install pkg-config
RUN add-apt-repository ppa:bitcoin/bitcoin
RUN apt-get update
RUN apt-get -y remove libdb++-dev
RUN apt-get -y install libdb4.8-dev libdb4.8++-dev
RUN apt-get -y install libevent-dev

WORKDIR /var/www/TillkWDM

COPY . ./.
COPY TillkWDMcoin.conf /root/.TillkWDMcoin/TillkWDMcoin.conf
VOLUME /root/.TillkWDMcoin

RUN cd ./src && mkdir ./obj/zerocoin && make -f makefile.unix -j $(nproc)

EXPOSE 17452/tcp

CMD /var/www/TillkWDM/src/TillkWDMd
