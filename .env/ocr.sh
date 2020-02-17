#!/usr/bin/env bash

ocr_library_import() {
    local _THIS_DIR=$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P);
    #source "${_THIS_DIR}/../config.sh" &>/dev/null \
    #    || source "./../config.sh" &>/dev/null;
    source "${_THIS_DIR}/basic.sh" &>/dev/null \
        || source "./basic.sh" &>/dev/null;
    source "${_THIS_DIR}/docker.sh" &>/dev/null \
        || source "./docker.sh" &>/dev/null;
}
ocr_library_import;

ocr_docker_command() {
    local DOCKER_IMAGE_TAG="tesseractshadow/tesseract4re";

    local HOME_DIR="$(user_home)";
    #local USER_DIR="/home/docker";
    local WORK_DIR="$(pwd)";

    local network="$(docker_network_preferred)";
    #local default_host="127.0.0.1";

    #local default_dns="8.8.8.8";
    #local dns1="$(dns_by_resolv "${default_dns}")";
    #local dns2="$(dns_by_nmcli "${default_dns}")";

    #echo "'${dns1}'"
    #echo "'${dns2}'"

    #return;

        #--add-host "$(uname -n):127.0.0.1" \
        #--volume "/etc/resolv.conf:/etc/resolv.conf" \
        #--volume "${_THIS_DIR}/../../build.properties:${USER_DIR}/build.properties" \
    #    --dns "${dns1}" \
    #    --dns "${dns2}" \

    docker run \
        --tty \
        --interactive \
        --rm \
        --dns "8.8.8.8" \
        --dns "8.8.4.4" \
        --dns "208.67.222.222" \
        --dns "208.67.220.220" \
        --user "$(id -u):$(id -g)"  \
        --hostname "$(uname -n)" \
        --net "${network}" \
        --env "TZ=CET" \
        --env "ENV_DOCKER_IMAGE_CONNECTED="${DOCKER_IMAGE_TAG}"" \
        --env "HOME=${HOME_DIR}" \
        --volume "${HOME_DIR}:${HOME_DIR}" \
        --volume "${WORK_DIR}:${WORK_DIR}" \
        --workdir "${WORK_DIR}" \
        "${DOCKER_IMAGE_TAG}" \
        "$@";
}
export -f ocr_docker_command;

ocr_docker_connect() {
    local command="$@";

    if [[ $( docker_check_installed ) -eq 0 ]]
    then
        throw_exception_exit "docker not installed";
        return;
    fi

    if [[ "${#command}" -gt 0 ]];
    then
        ocr_docker_command \
            /bin/bash --login -c \
            "${command}";
    else
        ocr_docker_command \
            /bin/bash --login;
    fi
}
export -f ocr_docker_connect;
