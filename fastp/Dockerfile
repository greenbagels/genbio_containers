# Fastp app
# Image: roysomak4/fastp

FROM registry.gitlab.com/roysomak4/genbio_containers/builder:c-cpp-v1 AS builder

USER bioseq
WORKDIR /home/bioseq

ENV APP_VER=0.23.2

# install build dependencies
# zlib is required by fasp during runtime
RUN wget https://github.com/OpenGene/fastp/archive/refs/tags/v${APP_VER}.tar.gz && \
    tar -zxvf v${APP_VER}.tar.gz && \
    cd fastp-${APP_VER} && \
    make -j 6 && \
    cp fastp /home/bioseq/fastp

# final image
FROM registry.gitlab.com/roysomak4/genbio_containers/genbio_base:bullseye

LABEL maintainer="Somak Roy<roysomak4@gmail.com>" \
    function="Docker image with fastp"

USER bioseq
WORKDIR /home/bioseq

COPY --from=builder /home/bioseq/fastp ./

RUN sudo install_packages libisal2 libdeflate0 parallel && \
    chmod a+x fastp && \
    sudo mv fastp /usr/local/bin/
