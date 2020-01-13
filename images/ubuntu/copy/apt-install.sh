#!/usr/bin/env sh

apt_install() {
    echo '# Updating apt' && \
        DEBIAN_FRONTEND=noninteractive && \
        apt-get -y update --allow-unauthenticated && \
    echo '# Updated apt' && \
    \
    \
    echo '# Installing dependencies' && \
        apt-get install -y \
            --fix-missing \
            --no-install-recommends \
            --no-install-suggests \
            --no-upgrade \
            --allow-unauthenticated \
            "$@" && \
    echo '# Installed dependencies' && \
    \
    \
    echo '# Cleaning up' && \
        apt-get -y clean && \
        apt-get -y autoclean && \
        apt-get -y autoremove && \
        rm -rf /var/lib/apt/lists/* /var/tmp/* /var/cache/apt/* && \
    echo '# Cleaned up'
}

apt_install "$@";
