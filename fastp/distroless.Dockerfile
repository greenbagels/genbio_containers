# Fastp app
# Image: registry.gitlab.com/roysomak4/genbio_containers/fastp

FROM registry.gitlab.com/roysomak4/genbio_containers/builder:v2 AS builder

ENV FASTP_VER=0.23.2 \
    PARALLEL_VER=20211222

# install fastp
RUN mkdir -p /usr/local/bin && \
    wget http://opengene.org/fastp/fastp.0.23.1 -O /usr/local/bin/fastp && \
    chmod a+x /usr/local/bin/fastp

# create final minimal OS image with apps
FROM scratch

LABEL maintainer="Somak Roy<roysomak4@gmail.com>" \
    function="Docker image with bwa and samtools" \
    source="https://gitlab.com/roysomak4/genbio_containers"

COPY --from=builder /usr/local/bin /usr/local/bin