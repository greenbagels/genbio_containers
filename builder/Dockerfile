# App builder image for compiling C/C++ apps
# Image: registry.gitlab.com/roysomak4/genbio_containers/builder:c-cpp-v1

FROM registry.gitlab.com/roysomak4/genbio_containers/genbio_base:buster

USER bioseq
WORKDIR /home/bioseq

RUN sudo install_packages build-essential wget curl zlib1g-dev gcc make g++ cmake git libdeflate-dev libisal-dev