FROM ubuntu:16.04

MAINTAINER Martin Sarajaervi "balony@gmail.com"


RUN apt-get update && apt-get install -y \
  build-essential autoconf libtool \
  git \
  pkg-config \
  cmake \
  && apt-get clean

ENV GRPC_RELEASE_TAG v1.0.0

RUN git clone -b ${GRPC_RELEASE_TAG} https://github.com/grpc/grpc /var/local/git/grpc

# install grpc
RUN cd /var/local/git/grpc && \
    git submodule update --init && \
    make && \
    make install && make clean

#install protoc
RUN cd /var/local/git/grpc/third_party/protobuf && \
    make && make install && make clean

RUN mkdir ~/.ssh
#ADD id_rsa /root/.ssh/id_rsa
#RUN cat $GITHUB_SSH_KEY > /root/.ssh/id_rsa

#RUN ssh-keyscan -t rsa github.com > ~/.ssh/known_hosts
RUN mkdir ~/git && cd ~/git && git clone https://github.com/Toeplitz/pwave_cloud.git
RUN cd ~/git/pwave_cloud && mkdir build && cd build && cmake .. && make 

#RUN rm -rf /root/pwave_cloud
#RUN mkdir /root/pwave_cloud
#COPY . /root/pwave_cloud
#RUN cd /root/pwave_cloud && cmake . && make 
#RUN mkdir /pwave_volume
#RUN df -h

ENTRYPOINT ["/root/pwave_cloud/pwave_server"]

