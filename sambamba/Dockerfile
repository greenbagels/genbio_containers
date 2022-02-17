# Sambamba app
# Image: registry.gitlab.com/roysomak4/genbio_containers/sambamba

FROM registry.gitlab.com/roysomak4/genbio_containers/builder:v2 AS builder

ENV SAMBAMBA_VER=0.8.2

# install sambamba
RUN wget https://github.com/biod/sambamba/releases/download/v${SAMBAMBA_VER}/sambamba-${SAMBAMBA_VER}-linux-amd64-static.gz && \
    gzip -d sambamba-${SAMBAMBA_VER}-linux-amd64-static.gz && \
    mv sambamba-${SAMBAMBA_VER}-linux-amd64-static sambamba && \
    chmod +x sambamba && \
    mkdir /usr/local/bin && \
    mv sambamba /usr/local/bin/
    # wget https://github.com/bwa-mem2/bwa-mem2/releases/download/v2.2.1/bwa-mem2-2.2.1_x64-linux.tar.bz2 && \
    # tar -xjf bwa-mem2-2.2.1_x64-linux.tar.bz2 && \
    # mv bwa-mem2-2.2.1_x64-linux/bwa-mem2* /usr/local/bin/

# create final minimal OS image with apps
FROM scratch

LABEL maintainer="Somak Roy<roysomak4@gmail.com>" \
    function="Docker image with sambamba"

# COPY --from=builder /install_root /
COPY --from=builder /usr/local /usr/local
COPY ./bwa-mem2* /usr/local/bin/

# RUN useradd bioseq

# USER bioseq
# WORKDIR /home/bioseq