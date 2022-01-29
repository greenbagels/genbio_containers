# FastQC app
# Image: registry.gitlab.com/roysomak4/genbio_containers/fastqc

FROM registry.gitlab.com/roysomak4/genbio_containers/builder:v2 AS builder

ENV FASTQC_VER=0.11.9

# install FASTQC
RUN wget https://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v${FASTQC_VER}.zip -O fastqc.zip && \
    unzip fastqc.zip && \
    rm fastqc.zip && \
    mkdir /usr/local/bin && \
    mv FastQC /usr/local/bin/ && \
    echo "perl /usr/local/bin/FastQC/fastqc" > /usr/local/bin/fastqc && \
    chmod +x /usr/local/bin/fastqc && \
    # install java runtime os package
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
    function="Docker image with FastQC"

COPY --from=builder /install_root /
COPY --from=builder /usr/local /usr/local

RUN useradd bioseq

USER bioseq
WORKDIR /home/bioseq
