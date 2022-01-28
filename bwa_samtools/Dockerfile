# bwa-mem2 and Samtools app
# Image: registry.gitlab.com/roysomak4/genbio_containers/bwa-samtools

FROM clearlinux:latest AS builder

ENV BWA_VER=2.2.1 \
	SAMTOOLS_VER=1.14 \
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
        bwa-mem2==${BWA_VER} \
        samtools==${SAMTOOLS_VER} && \
    # remove ancillary files not required in final image
    rm -r /usr/local/share /usr/local/man /usr/local/conda-meta

# create final minimal OS image with apps
FROM scratch

LABEL maintainer="Somak Roy<roysomak4@gmail.com>" \
    function="Docker image with bwa and samtools"

COPY --from=builder /install_root /
COPY --from=builder /usr/local /usr/local

RUN useradd bioseq

USER bioseq
WORKDIR /home/bioseq