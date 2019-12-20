FROM debian:latest
MAINTAINER Mikhail Gasanov <grol81@mail.ru>
RUN apt-get update && apt-get install -y python2.7 build-essential python-dev curl unzip tar git wget && rm -rf /var/lib/apt/lists/*
RUN cd; wget https://github.com/Kitware/CMake/releases/download/v3.16.1/cmake-3.16.1-Linux-x86_64.tar.gz && tar -xf cmake-3.16.1-Linux-x86_64.tar.gz
ENV PATH=~/cmake-3.16.1-Linux-x86_64/bin:~/zalf-rpm/monica/_cmake_linux:$PATH
ENV MONICA_PARAMETERS=~/zalf-rpm/monica-parameters
RUN cd ~ && mkdir zalf-rpm && cd zalf-rpm && git clone https://github.com/zalf-rpm/monica.git && git clone https://github.com/zalf-rpm/monica-parameters.git && git clone https://github.com/zalf-rpm/util.git && git clone https://github.com/zalf-rpm/capnproto_schemas.git && git clone https://github.com/Microsoft/vcpkg.git && cd vcpkg && ./bootstrap-vcpkg.sh && ./vcpkg install zeromq:x64-linux && ./vcpkg install capnproto:x64-linux
RUN cd ~/zalf-rpm/monica; sh update_linux.sh; cd ~/zalf-rpm/monica/_cmake_linux; make