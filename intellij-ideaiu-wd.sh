#!/usr/bin/env bash

intellij_ideaiu() {
    local _THIS_DIR;
    _THIS_DIR=$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P);

    source ${_THIS_DIR}/.env/basic.sh;
    source ./.env/basic.sh &>/dev/null;
    source ${_THIS_DIR}/.env/docker.sh;
    source ./.env/docker.sh &>/dev/null;

    docker_socket_enable;

    local DOCKER_IMAGE_TAG="ehrlichandreas/workbase-intellij-idea:u-2019.3.1";

    local network;
    network="$(docker_network_preferred)";

    local default_dns="8.8.8.8";
    local dns1;
    dns1="$(dns_by_resolv "${default_dns}")";
    local dns2;
    dns2="$(dns_by_nmcli "${default_dns}")";

    mkdir -p "${_THIS_DIR}/.env";

    docker run \
        -it \
        --rm \
        --dns "${dns1}" \
        --dns "${dns2}" \
        --dns "8.8.8.8" \
        --dns "8.8.4.4" \
        --dns "208.67.222.222" \
        --dns "208.67.220.220" \
        --net "${network}" \
        --env "DISPLAY=${DISPLAY}" \
        --env "GIT_DISCOVERY_ACROSS_FILESYSTEM=1" \
        --env "HOME=${_THIS_DIR}/.env" \
        --env "NO_AT_BRIDGE=1" \
        --env "TZ=CET" \
        --hostname "$(uname -n)" \
        --user "$(id -u):$(id -g)"  \
        --volume "/run/user/$(id -u)/:/run/user/$(id -u)/" \
        --volume "/tmp/.X11-unix:/tmp/.X11-unix" \
        --volume "/var/run/docker.sock:/var/run/docker.sock" \
        --volume "${_THIS_DIR}/.env:/home/docker" \
        --volume "${_THIS_DIR}:${_THIS_DIR}" \
        --workdir "${_THIS_DIR}" \
        --name "intellij-ideaiu-$(head -c 4 /dev/urandom | xxd -p)-$(date +'%Y%m%d-%H%M%S')" \
        "${DOCKER_IMAGE_TAG}" \
        "$@";
}

intellij_ideaiu "$@";
