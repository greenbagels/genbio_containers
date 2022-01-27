# App builder image for compiling C/C++ and other apps
# Image: registry.gitlab.com/roysomak4/genbio_containers/builder:c-cpp-v1

FROM clearlinux:latest

RUN swupd update --quiet -y && \
    swupd bundle-add \
        c-basic \
        make \
        devpkg-bzip2 \
        devpkg-ncurses \
        devpkg-zlib \
        devpkg-xz \
        curl \
        wget \
        git \
        devpkg-curl \
        devpkg-openssl
