# Builder image
# Image: registry.gitlab.com/roysomak4/genbio_containers/builder

FROM clearlinux:latest


ENV CLEAR_VER=35750
# --allow-insecure-http flag when used for intergal registry with self-signed certs
RUN swupd bundle-add --allow-insecure-http --no-progress curl wget less which git os-core-search unzip c-extras-gcc9 && \
    curl -sL https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-pypy3-Linux-x86_64.sh \
        -o /tmp/mambaforge.sh && \
    sh /tmp/mambaforge.sh -bfp /usr && \
    # install minimal clearlinux OS for target image
    swupd os-install \
        --no-progress \
        --no-boot-update \
        --no-script \
        --version ${CLEAR_VER} \
        --path /install_root \
        --statedir /swupd-state \
        --bundles os-core
