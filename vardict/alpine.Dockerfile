#########################################################################
#    Dockerfile for VarDictJava                                         #
#    registry.gitlab.com/roysomak4/genbio_containers/vardict            #
#########################################################################

# source alpine image
FROM alpine:3.15

# add label
LABEL maintainer="Somak Roy<roysomak4@gmail.com>" \
        function="Docker image for VarDictJava using alpine base image"

ENV VARDICT_VER=1.8.3

# install vardict
RUN apk update && apk add --no-cache --virtual build_deps \
        wget \
        # install runtime dependencies
        && apk add --no-cache R openjdk8-jre perl pcre xz-libs libbz2 parallel \
        # download vardict
        && wget "https://github.com/AstraZeneca-NGS/VarDictJava/releases/download/v${VARDICT_VER}/VarDict-${VARDICT_VER}.tar" \
        && tar -xvf VarDict-${VARDICT_VER}.tar \
        && mv VarDict-${VARDICT_VER} vardict_app \
        && rm VarDict-${VARDICT_VER}.tar \
        # clean up install mess
        && apk del build_deps \
        && rm -rf /var/cache/apk/* \
        && ln -s vardict_app/bin/VarDict vardict
