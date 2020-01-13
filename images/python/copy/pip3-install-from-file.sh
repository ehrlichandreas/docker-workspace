#!/usr/bin/env sh

pip3_install_from_file() {
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
    sh "${_THIS_DIR}/pip3-install.sh" ${dependencies};
}

pip3_install_from_file "$@"
