# bcftools
# Image: registry.gitlab.com/roysomak4/genbio_containers/cnvkit

FROM registry.gitlab.com/roysomak4/genbio_containers/builder:v2-clearlinux AS builder

# Use mamba to install cnvkit and dependencies into /usr/local
ENV CNVKIT=0.9.9
RUN mamba create -qy -p /usr/local \
        -c bioconda \
        cnvkit==${CNVKIT}

# Deploy the minimal OS and target tools into a blank image
FROM scratch

LABEL maintainer="Somak Roy<roysomak4@gmail.com>" \
    function="Docker image with bwa-mem2" \
    source="https://gitlab.com/roysomak4/genbio_containers"

COPY --from=builder /install_root /
COPY --from=builder /usr/local /usr/local
