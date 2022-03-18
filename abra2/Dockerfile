# Abra2
# Image: registry.gitlab.com/roysomak4/genbio_containers/abra2

FROM registry.gitlab.com/roysomak4/genbio_containers/builder:v2-clearlinux AS builder

ENV ABRA_VER=2.23 \
    CLEAR_VER=36030

# download abra2
RUN wget https://github.com/mozack/abra2/releases/download/v${ABRA_VER}/abra2-${ABRA_VER}.jar -O /abra2.jar && \
    mkdir /usr/local/bin && \
    mv abra2.jar /usr/local/bin/ && \
    # install java runtime os package
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
    function="Docker image with Abra2"

COPY --from=builder /install_root /
COPY --from=builder /usr/local/bin/abra2.jar /usr/bin/abra2.jar