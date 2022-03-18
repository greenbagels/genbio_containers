# Builder image
# Image: registry.gitlab.com/roysomak4/genbio_containers/builder

FROM clearlinux:latest


ENV CLEAR_VER=36030
# --allow-insecure-http flag when used for intergal registry with self-signed certs
RUN swupd bundle-add --allow-insecure-http --no-progress \
        curl \
        wget \
        less \
        which \
        git \
        os-core-search \
        unzip \
        c-extras-gcc9 && \
    # install minimal clearlinux OS for target image
    swupd os-install \
        --no-progress \
        --no-boot-update \
        --no-script \
        --version ${CLEAR_VER} \
        --path /install_root \
        --statedir /swupd-state \
        --bundles os-core
