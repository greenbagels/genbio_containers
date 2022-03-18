# FastQC app
# Image: registry.gitlab.com/roysomak4/genbio_containers/fastqc

FROM registry.gitlab.com/roysomak4/genbio_containers/builder:v2-clearlinux AS builder

ENV FASTQC_VER=0.11.9 \
    CLEAR_VER=36030

# install FASTQC
RUN wget --no-check-certificate https://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v${FASTQC_VER}.zip -O fastqc.zip && \
    unzip fastqc.zip && \
    rm fastqc.zip && \
    mkdir /usr/local/bin && \
    mv FastQC/* /usr/local/bin/ && \
    chmod +x /usr/local/bin/fastqc && \
    # install java & perl runtime os package
    swupd os-install \
        --no-progress \
        --no-boot-update \
        --no-script \
        --version ${CLEAR_VER} \
        --path /install_root \
        --statedir /swupd-state \
        --bundles os-core,java-runtime,perl-basic

# create final minimal OS image with apps
FROM scratch

LABEL maintainer="Somak Roy<roysomak4@gmail.com>" \
    function="Docker image with FastQC" \
    source="https://gitlab.com/roysomak4/genbio_containers"

COPY --from=builder /install_root /
COPY --from=builder /usr/local /usr/local
