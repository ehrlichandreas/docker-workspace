#!/usr/bin/env bash

build_docker_images() {
    local _THIS_DIR="$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)";

    local TIME_START="$(date '+%s')";


    cd "${_THIS_DIR}";
    cd "ubuntu";
    bash buildDockerImage.sh;

    cd "${_THIS_DIR}";
    cd "docker-in-docker";
    bash buildDockerImage.sh;

    cd "${_THIS_DIR}";
    cd "python";
    bash buildDockerImage.sh;

    cd "${_THIS_DIR}";
    cd "aws-cli";
    bash buildDockerImage.sh;

    cd "${_THIS_DIR}";
    cd "terraform";
    bash buildDockerImage.sh;

    cd "${_THIS_DIR}";
    cd "environment";
    bash buildDockerImage.sh;

    cd "${_THIS_DIR}";
    cd "ide-base";
    bash buildDockerImage.sh;

    cd "${_THIS_DIR}";
    cd "intellij-idea-u";
    bash buildDockerImage.sh;

    cd "${_THIS_DIR}";
    cd "lyx";
    bash buildDockerImage.sh;

    cd "${_THIS_DIR}";
    cd "util-base";
    bash buildDockerImage.sh;

    cd "${_THIS_DIR}";
    cd "util-imagemagick";
    bash buildDockerImage.sh;

    cd "${_THIS_DIR}";
    cd "util-pdf";
    bash buildDockerImage.sh;

    cd "${_THIS_DIR}";
    cd "util-scanner";
    bash buildDockerImage.sh;


    local TIME_END="$(date '+%s')";
    local TIME_ELAPSED="$(expr ${TIME_END} - ${TIME_START})";

    echo "";
    cat << EOF

##
# Builds completed in ${TIME_ELAPSED} seconds.
##

EOF
}

build_docker_images "$@";
