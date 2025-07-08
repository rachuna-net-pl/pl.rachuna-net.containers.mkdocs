FROM ubuntu:noble

ARG CONTAINER_VERSION="0.0.0"

LABEL Author='Maciej Rachuna'
LABEL Application='pl.rachuna-net.containers.mkdocs'
LABEL Description='Mkdocs container image'
LABEL version="${CONTAINER_VERSION}"

ENV DEBIAN_FRONTEND=noninteractive

COPY scripts/ /opt/scripts/

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
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    # Install mkdocs
    && pip3 install --no-cache-dir --break-system-packages --ignore-installed \
        mkdocs-material \
        mkdocs-material[imaging] \
    
    # Make scripts executable
    && chmod +x /opt/scripts/*.bash \

    # Create a non-root user and set permissions
    && useradd -m -s /bin/bash nonroot \
    && chown -R nonroot:nonroot /opt/scripts

USER nonroot

ENTRYPOINT [ "/opt/scripts/entrypoint.bash" ]
