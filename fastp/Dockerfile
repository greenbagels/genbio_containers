# Fastp app
# Image: registry.gitlab.com/roysomak4/genbio_containers/fastp

FROM clearlinux:latest AS builder

ENV FASTP_VER=0.23.2 \
    PARALLEL_VER=20211222 \
	CLEAR_VER=35750

RUN swupd bundle-add --no-progress curl && \
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
        --bundles os-core && \
    # install bwa and samtools
    mamba create -qy -p /usr/local \
        -c bioconda \
        fastp==${FASTP_VER} \
        parallel==${PARALLEL_VER} && \
    # remove ancillary files not required in final image
    rm -rf /usr/local/share /usr/local/conda-meta /usr/local/man

# create final minimal OS image with apps
FROM scratch

LABEL maintainer="Somak Roy<roysomak4@gmail.com>" \
    function="Docker image with bwa and samtools"

COPY --from=builder /install_root /
COPY --from=builder /usr/local /usr/local

RUN useradd bioseq

USER bioseq
WORKDIR /home/bioseq
