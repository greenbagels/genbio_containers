# mosdepth app
# Image: registry.gitlab.com/roysomak4/genbio_containers/mosdepth

FROM registry.gitlab.com/roysomak4/genbio_containers/builder:v2-clearlinux AS builder

ENV MOSDEPTH_VER=0.3.3

# install mosdepth
RUN wget https://github.com/brentp/mosdepth/releases/download/v${MOSDEPTH_VER}/mosdepth && \
    chmod a+x mosdepth && \
    mkdir /usr/local/bin && \
    mv mosdepth /usr/local/bin/

# create final minimal OS image with apps
FROM scratch

LABEL maintainer="Somak Roy<roysomak4@gmail.com>" \
    function="Docker image with mosdepth" \
    source="https://gitlab.com/roysomak4/genbio_containers"

COPY --from=builder /install_root /
COPY --from=builder /usr/local /usr/local