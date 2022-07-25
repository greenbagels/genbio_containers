# cnaplotr
# Image: registry.gitlab.com/roysomak4/genbio_containers/cnaplotr

FROM python:3.10-slim-bullseye

LABEL maintainer="Somak Roy<roysomak4@gmail.com>" \
    function="Docker image with cnaplotr" \
    source="https://gitlab.com/roysomak4/genbio_containers"

COPY requirements.txt .

RUN apt update && apt install -y wget && \
    pip3 install -r requirements.txt && \
    pip3 cache purge && \
    wget https://raw.githubusercontent.com/roysomak4/cnaplotr/main/cnaplotr.py && \
    apt remove -y wget && \
    apt clean && \
    rm requirements.txt
