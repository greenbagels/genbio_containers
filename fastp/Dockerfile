# Fastp app
# Image: registry.gitlab.com/roysomak4/genbio_containers/fastp

FROM registry.gitlab.com/roysomak4/genbio_containers/builder:v1 AS builder

ENV FASTP_VER=0.23.2 \
    PARALLEL_VER=20211222

# install fastp
RUN mamba create -qy -p /usr/local \
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
