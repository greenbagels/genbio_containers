# Builder image
# Image: registry.gitlab.com/roysomak4/genbio_containers/builder

FROM clearlinux:latest

# to compile bwa on clearlinux we need to install gcc/g++ version 9, since version 11 (part of the bundle) causes compilation error.
# To enable it, update the CXX environment variable
# export CXX=g++-9
# modify the makefile for bwa where it checks for CXX flag == g++ (set it to g++-9)
ENV CLEAR_VER=35750
# --allow-insecure-http flag when used for intergal registry with self-signed certs
RUN swupd bundle-add --allow-insecure-http --no-progress curl wget less which git os-core-search unzip c-basic && \
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
