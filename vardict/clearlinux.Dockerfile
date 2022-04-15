# Vardict app
# Image: registry.gitlab.com/roysomak4/genbio_containers/vardict

FROM registry.gitlab.com/roysomak4/genbio_containers/builder:v2 AS builder

ENV VARDICT_VER=1.8.3

# install FASTQC
RUN wget https://github.com/AstraZeneca-NGS/VarDictJava/releases/download/v${VARDICT_VER}/VarDict-${VARDICT_VER}.tar -O vardict.tar && \
    tar -xf vardict.tar && \
    mkdir /usr/local/bin && \
    mv VarDict-${VARDICT_VER} /usr/local/bin/vardict_app && \
    rm -r vardict.tar && \
    # install java & perl runtime os package
    swupd os-install \
        --no-progress \
        --no-boot-update \
        --no-script \
        --version ${CLEAR_VER} \
        --path /install_root \
        --statedir /swupd-state \
        --bundles os-core,java-runtime,perl-basic,R-basic,devpkg-pcre2,xz,devpkg-bzip2

# create final minimal OS image with apps
FROM scratch

LABEL maintainer="Somak Roy<roysomak4@gmail.com>" \
    function="Docker image with Vardict"

COPY --from=builder /install_root /

RUN useradd bioseq

USER bioseq
WORKDIR /home/bioseq

COPY --from=builder /usr/local/bin/vardict_app ./
