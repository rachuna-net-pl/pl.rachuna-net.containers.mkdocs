FROM ubuntu:noble

ARG CONTAINER_VERSION="0.0.0"

LABEL Author='Maciej Rachuna'
LABEL Application='pl.rachuna-net.containers.mkdocs'
LABEL Description='Mkdocs container image'
LABEL version="${CONTAINER_VERSION}"

# Install packages
RUN apt-get update && apt-get --no-install-recommends install -y \
        git \
        libcairo2-dev \
        libffi-dev \
        libfreetype6-dev \
        libjpeg-dev \
        libpng-dev \
        libz-dev \
        python3-pip \
    && rm -rf /usr/lib/python3.12/EXTERNALLY-MANAGED \
    && pip install --ignore-installed mkdocs-material mkdocs-material[imaging] \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /docs
