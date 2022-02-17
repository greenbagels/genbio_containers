# bwa-mem2 and Samtools app
# Image: registry.gitlab.com/roysomak4/genbio_containers/bwa-samtools

FROM registry.gitlab.com/roysomak4/genbio_containers/builder:v1 AS builder

ENV BWA_VER=2.2.1 \
	SAMTOOLS_VER=1.14 \
    PARALLEL_VER=20211222

# # install bwa and samtools
# RUN mamba create -qy -p /usr/local \
#         -c bioconda \
#         bwa-mem2==${BWA_VER} \
#         samtools==${SAMTOOLS_VER} \
#         parallel==${PARALLEL_VER} && \
#     # remove ancillary files not required in final image
#     rm -r /usr/local/share /usr/local/man /usr/local/conda-meta

# create final minimal OS image with apps
FROM scratch

LABEL maintainer="Somak Roy<roysomak4@gmail.com>" \
    function="Docker image with bwa and samtools"

# COPY --from=builder /install_root /
COPY ./bwa-mem* /usr/bin/
#COPY --from=builder /usr/local /usr/local

# RUN useradd bioseq

# USER bioseq
# WORKDIR /home/bioseq