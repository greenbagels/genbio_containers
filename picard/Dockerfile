# Picard tools
# Image: registry.gitlab.com/roysomak4/genbio_containers/picard

FROM registry.gitlab.com/roysomak4/genbio_containers/builder:v2 AS builder

ENV PICARD_VER=2.26.10

# install FASTQC
RUN wget https://github.com/broadinstitute/picard/releases/download/${PICARD_VER}/picard.jar && \
    mkdir /usr/local/bin && \
    mv picard.jar /usr/local/bin/ && \
    # install java & perl runtime os package
    swupd os-install \
        --no-progress \
        --no-boot-update \
        --no-script \
        --version ${CLEAR_VER} \
        --path /install_root \
        --statedir /swupd-state \
        --bundles os-core,java-runtime

# create final minimal OS image with apps
FROM scratch

LABEL maintainer="Somak Roy<roysomak4@gmail.com>" \
    function="Docker image with Picard tools" \
    source="https://gitlab.com/roysomak4/genbio_containers"

COPY --from=builder /install_root /

RUN useradd bioseq

USER bioseq
WORKDIR /home/bioseq

COPY --from=builder /usr/local/bin/picard.jar /home/bioseq/picard.jar