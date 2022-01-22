# Base debian image
# Image: registry.gitlab.com/roysomak4/genbio_containers/genbio_base:buster

FROM bitnami/minideb:buster

LABEL maintainer="Somak Roy, roysomak4@gmail.com" \
    function="Base debian image for non root user with sudo"

ENV NON_ROOT_USER=bioseq

RUN apt update && apt upgrade -y && \
    install_packages sudo && \
    useradd ${NON_ROOT_USER} && \
    mkdir /home/${NON_ROOT_USER} && \
    usermod -aG sudo ${NON_ROOT_USER} && \
    echo "sudo ALL=(ALL:ALL) NOPASSWD:ALL" >>/etc/sudoers && \
    echo "${NON_ROOT_USER} ALL=(ALL:ALL) NOPASSWD:ALL" >>/etc/sudoers

USER ${NON_ROOT_USER}

WORKDIR /home/bioseq