#!/usr/bin/env bash

auto_update_terraform() {
    dpkgArch="$(dpkg --print-architecture)"; \
    case "${dpkgArch##*-}" in \
        amd64) dockerArch='amd64' ;; \
        i386)  dockerArch='386' ;; \
        *) echo >&2 "error: unsupported architecture ($dpkgArch)"; exit 1 ;;\
    esac; \
        \
    local INSTALL_DIR="${1:-/usr/local/bin}" && \
    local URL="https://releases.hashicorp.com/terraform" && \
        \
    local VER="$(curl -sL ${URL} | grep -v beta | grep -v rc1 | grep '<a href="'.*terraform | cut -d'/' -f3 | sort -n | head -n 1)" && \
    local TERRAFORM_VERSION="${2:-${VER}}" && \
    local ZIP="terraform_${TERRAFORM_VERSION}_linux_${dockerArch}.zip" && \
        \
    echo "* Downloading ${URL}/${TERRAFORM_VERSION}/${ZIP}" && \
    if ! curl -fL -o ${INSTALL_DIR}/${ZIP} "${URL}/${TERRAFORM_VERSION}/${ZIP}"; then \
        echo >&2 "error: failed to download 'terraform-${TERRAFORM_VERSION}' for '${dockerArch}'"; \
        exit 1; \
    fi; \
    echo "* Extracting ${ZIP} into ${INSTALL_DIR}" && \
    unzip -o ${INSTALL_DIR}/${ZIP} -d ${INSTALL_DIR} && \
    rm -v ${INSTALL_DIR}/${ZIP}
}

auto_update_terraform "$@";
