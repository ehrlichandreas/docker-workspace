#!/usr/bin/env sh

apt_install_from_file() {
    local _THIS_DIR="$( cd -P -- "$( dirname -- "$0" )" && pwd -P )";

    # shellcheck disable=SC2034
    local dependencies="$(
        cat "$@" | \
        sed '/^[[:space:]]*$/d' | \
        sed '/^#/d' | \
        sort -u | \
        tr '\n' ' ' | \
        sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//'
    )" && \
    sh "${_THIS_DIR}/apt-install.sh" ${dependencies};
}

apt_install_from_file "$@"
