# itdseek
# Image: registry.gitlab.com/roysomak4/genbio_containers/itdseek

FROM registry.gitlab.com/roysomak4/genbio_containers/builder:v2-clearlinux AS builder

ENV SAMTOOLS_VER=1.15 \
    CLEAR_VER=36030

# Download samtools release tarball
RUN wget https://github.com/samtools/samtools/releases/download/${SAMTOOLS_VER}/samtools-${SAMTOOLS_VER}.tar.bz2 -O samtools.tar.bz2 && \
    tar -jxvf samtools.tar.bz2 && \
    mv samtools-${SAMTOOLS_VER} samtools && \
    cd samtools && \
    # install samtools. Default install location /usr/local
    ./configure && \
    make -j 8 && make install && \
    cd htslib-1.15 && \
    ./configure && \
    make -j 8 && make install && \
    # install itdseek
    wget https://raw.githubusercontent.com/roysomak4/itdseek/master/itdseek_hg38.sh -O /usr/local/bin/itdseek_hg38.sh && \
    wget https://raw.githubusercontent.com/roysomak4/itdseek/master/itdseek.pl -O /usr/local/bin/itdseek.pl && \
    chmod +x /usr/local/bin/itdseek_hg38.sh && \
    chmod +x /usr/local/bin/itdseek.pl && \
    # install minimal clearlinux OS with C++ standard lib & perl for target image
    rm -r /install_root && \
    swupd os-install \
        --no-progress \
        --no-boot-update \
        --no-script \
        --version ${CLEAR_VER} \
        --path /install_root \
        --statedir /swupd-state \
        --bundles os-core,libstdcpp,xz,curl,perl-basic

COPY --from=clearlinux:latest /usr/bin/bzip2 /install_root/usr/bin/bzip2
COPY --from=clearlinux:latest /usr/lib64/libbz2* /install_root/usr/lib64/

# create final minimal OS image with apps
FROM scratch

LABEL maintainer="Somak Roy<roysomak4@gmail.com>" \
    function="Docker image with ITDseek and samtools" \
    source="https://gitlab.com/roysomak4/genbio_containers"

COPY --from=builder /install_root /
COPY --from=builder /usr/local /usr/local