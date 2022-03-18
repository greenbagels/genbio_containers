# bcftools
# Image: registry.gitlab.com/roysomak4/genbio_containers/bcftools

FROM registry.gitlab.com/roysomak4/genbio_containers/builder:v2-clearlinux AS builder

ENV BCFTOOLS_VER=1.15 \
    CLEAR_VER=36030

# Download bwa-mem2 binaries
RUN wget https://github.com/samtools/bcftools/releases/download/${BCFTOOLS_VER}/bcftools-${BCFTOOLS_VER}.tar.bz2 -O bcftools.tar.bz2 && \
    tar -jxvf bcftools.tar.bz2 && \
    mv bcftools-${BCFTOOLS_VER} bcftools && \
    cd bcftools && \
    # install bcftools. Default install location /usr/local
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
    function="Docker image with bcftools" \
    source="https://gitlab.com/roysomak4/genbio_containers"

COPY --from=builder /install_root /
COPY --from=builder /usr/local /usr/local
