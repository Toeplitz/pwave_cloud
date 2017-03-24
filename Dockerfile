FROM ubuntu:16.04

RUN apt-get update && apt-get install -y \
  build-essential autoconf libtool \
  git \
  pkg-config \
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

RUN mkdir ~/git && cd ~/git && git clone git@github.com:Toeplitz/pwave_cloud.git
RUN cd ~/git/pwave_cloud && mkdir build && cd build && cmake .. && make && ./server

