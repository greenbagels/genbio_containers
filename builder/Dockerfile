# App builder image for compiling C/C++ apps
# Image: registry.gitlab.com/roysomak4/genbio_containers/builder:c-cpp-v1

FROM registry.gitlab.com/roysomak4/genbio_containers/genbio_base:bullseye

USER bioseq
WORKDIR /home/bioseq

RUN sudo install_packages build-essential wget curl zlib1g-dev gcc make g++ cmake git libdeflate-dev libisal-dev dh-autoreconf libbz2-dev liblzma-dev libcurl4-gnutls-dev libssl-dev libncurses5-dev perl