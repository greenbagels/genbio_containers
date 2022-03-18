# bcl convert
# Image: registry.gitlab.com/roysomak4/genbio_containers/bcl_convert

FROM centos:7.9.2009 AS stage1

COPY ./bcl-convert-3.9.3-2.el7.x86_64.rpm ./bcl-convert.rpm

RUN yum install -yq gdb && rpm --install bcl-convert.rpm && \
    rm -r bcl-convert.rpm


FROM clearlinux:latest AS stage2

ENV CLEAR_VER=36030

# install minimal clearlinux OS with C++ standard lib for target image
RUN swupd os-install \
        --no-progress \
        --no-boot-update \
        --no-script \
        --version ${CLEAR_VER} \
        --path /install_root \
        --statedir /swupd-state \
        --bundles os-core,libstdcpp,xz


# create final minimal OS image with apps
FROM scratch

LABEL maintainer="Somak Roy<roysomak4@gmail.com>" \
    function="Docker image with bcl-convert" \
    source="https://gitlab.com/roysomak4/genbio_containers"

COPY --from=stage2 /install_root /
COPY --from=stage1 /usr/bin/bcl-convert /usr/bin/bcl-convert