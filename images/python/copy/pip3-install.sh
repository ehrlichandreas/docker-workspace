#!/usr/bin/env sh

pip3_install() {
    echo '# Installing dependencies' && \
        pip3 install \
            --upgrade \
            --disable-pip-version-check \
            --no-cache-dir \
            "$@" && \
    echo '# Installed dependencies'
}

pip3_install "$@";
