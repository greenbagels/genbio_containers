# bwa-mem2 and Samtools app
# Image: registry.gitlab.com/roysomak4/genbio_containers/bwa-mem2_sambamba

FROM registry.gitlab.com/roysomak4/genbio_containers/builder:v2 AS builder

ENV BWA_VER=2.2.1 \
    CLEAR_VER=35750 \
    SAMBAMBA_VER=0.8.2

# Download bwa-mem2 binaries
RUN wget https://github.com/bwa-mem2/bwa-mem2/releases/download/v${BWA_VER}/bwa-mem2-${BWA_VER}_x64-linux.tar.bz2 && \
    tar -jxvf bwa-mem2-${BWA_VER}_x64-linux.tar.bz2 && \
    mkdir /usr/local/bin && \
    mv bwa-mem2-${BWA_VER}_x64-linux/bwa-mem2* /usr/local/bin/ && \
    # Download sambamba static binary
    wget https://github.com/biod/sambamba/releases/download/v${SAMBAMBA_VER}/sambamba-${SAMBAMBA_VER}-linux-amd64-static.gz && \
    gzip -d sambamba-${SAMBAMBA_VER}-linux-amd64-static.gz && \
    mv sambamba-${SAMBAMBA_VER}-linux-amd64-static sambamba && \
    chmod a+x sambamba && \
    mv sambamba /usr/local/bin/ && \ 
    # install minimal clearlinux OS with C++ standard lib for target image
    rm -r /install_root && \
    swupd os-install \
        --no-progress \
        --no-boot-update \
        --no-script \
        --version ${CLEAR_VER} \
        --path /install_root \
        --statedir /swupd-state \
        --bundles os-core,libstdcpp

# create final minimal OS image with apps
FROM scratch

LABEL maintainer="Somak Roy<roysomak4@gmail.com>" \
    function="Docker image with bwa"

COPY --from=builder /install_root /
COPY --from=builder /usr/local /usr/local

RUN useradd bioseq

USER bioseq
WORKDIR /home/bioseq