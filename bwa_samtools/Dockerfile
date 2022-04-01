# bwa-mem2 and samtools
# Image: registry.gitlab.com/roysomak4/genbio_containers/bwa-mem2_samtools

FROM registry.gitlab.com/roysomak4/genbio_containers/builder:v2-clearlinux AS builder

ENV BWA_VER=2.2.1 \
    SAMTOOLS_VER=1.15 \
    CLEAR_VER=36030

# Install bwa-mem2
RUN wget https://github.com/bwa-mem2/bwa-mem2/releases/download/v${BWA_VER}/bwa-mem2-${BWA_VER}_x64-linux.tar.bz2 && \
    tar -jxvf bwa-mem2-${BWA_VER}_x64-linux.tar.bz2 && \
    mkdir /usr/local/bin && \
    mv bwa-mem2-${BWA_VER}_x64-linux/bwa-mem2* /usr/local/bin/ && \
    # Download samtools release tarball
    wget https://github.com/samtools/samtools/releases/download/${SAMTOOLS_VER}/samtools-${SAMTOOLS_VER}.tar.bz2 -O samtools.tar.bz2 && \
    tar -jxvf samtools.tar.bz2 && \
    mv samtools-${SAMTOOLS_VER} samtools && \
    cd samtools && \
    # install samtools. Default install location /usr/local
    ./configure && \
    make -j 8 && make install && \
    cd htslib-1.15 && \
    ./configure && \
    make -j 8 && make install && \
    # install minimal clearlinux OS with C++ standard lib for target image
    rm -r /install_root && \
    swupd os-install \
        --no-progress \
        --no-boot-update \
        --no-script \
        --version ${CLEAR_VER} \
        --path /install_root \
        --statedir /swupd-state \
        --bundles os-core,libstdcpp,xz,curl

COPY --from=clearlinux:latest /usr/bin/bzip2 /install_root/usr/bin/bzip2
COPY --from=clearlinux:latest /usr/lib64/libbz2* /install_root/usr/lib64/

# create final minimal OS image with apps
FROM scratch

LABEL maintainer="Somak Roy<roysomak4@gmail.com>" \
    function="Docker image with bwa mem2 and samtools" \
    source="https://gitlab.com/roysomak4/genbio_containers"

COPY --from=builder /install_root /
COPY --from=builder /usr/local /usr/local
