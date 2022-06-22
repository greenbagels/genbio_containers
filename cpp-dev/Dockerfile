# development container for C/C++
# Image: registry.gitlab.com/roysomak4/genbio_containers/cpp-dev

FROM ubuntu:22.04

# Install C/C++ compilers and build tools
RUN apt update && \
    apt upgrade -y && \
    apt install -y build-essential cmake autoconf automake gcc-11-locales ca-certificates git clang nano wget curl htop && \
    # Static compile zlib from source
    mkdir zlib && cd zlib && \
    wget https://www.zlib.net/zlib-1.2.12.tar.gz && \
    tar -zxvf zlib-1.2.12.tar.gz && \
    cd zlib-1.2.12 && \
    ./configure --static && make -j 4 && make install && \
    cd ../../ && rm -r zlib && \
    # install gzstream library
    git clone https://github.com/roysomak4/gzstream.git && \
    cd gzstream && \
    make install && \
    cd ../ && rm -r gzstream

LABEL maintainer="Somak Roy<roysomak4@gmail.com>" \
    function="Docker image with C/C++ dev environment" \
    source="https://gitlab.com/roysomak4/genbio_containers"
