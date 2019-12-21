FROM debian:latest
MAINTAINER Mikhail Gasanov <grol81@mail.ru>
RUN apt-get update && apt-get install -y python2.7 build-essential python-dev curl unzip tar git wget && rm -rf /var/lib/apt/lists/*
RUN cd; wget https://github.com/Kitware/CMake/releases/download/v3.16.1/cmake-3.16.1-Linux-x86_64.tar.gz && tar -xf cmake-3.16.1-Linux-x86_64.tar.gz
RUN export PATH=/root/cmake-3.16.1-Linux-x86_64/bin:/root/zalf-rpm/monica/_cmake_linux:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin; export MONICA_PARAMETERS=/root/zalf-rpm/monica-parameters
RUN cd ~ && mkdir zalf-rpm && cd zalf-rpm && git clone https://github.com/zalf-rpm/monica.git && git clone https://github.com/zalf-rpm/monica-parameters.git && git clone https://github.com/zalf-rpm/util.git && git clone https://github.com/zalf-rpm/capnproto_schemas.git && git clone https://github.com/Microsoft/vcpkg.git && cd vcpkg && ./bootstrap-vcpkg.sh && ./vcpkg install zeromq:x64-linux && ./vcpkg install capnproto:x64-linux
RUN cd /root/zalf-rpm/monica; sh update_linux.sh; cd /root/zalf-rpm/monica/_cmake_linux; make
RUN echo "export PATH=/root/cmake/cmake-3.16.1-Linux-x86_64/bin:/root/zalf-rpm/monica/_cmake_linux:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin >> /root/.bashrc"; echo "export MONICA_PARAMETERS=/root/zalf-rpm/monica-parameters" >> /root/.bashrc
