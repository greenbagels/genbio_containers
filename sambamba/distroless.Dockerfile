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

# create final minimal OS image with apps
FROM scratch

LABEL maintainer="Somak Roy<roysomak4@gmail.com>" \
    function="Docker image with sambamba" \
    source="https://gitlab.com/roysomak4/genbio_containers"

COPY --from=builder /usr/local/bin /usr/local/bin
