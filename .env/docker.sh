#!/usr/bin/env bash

docker_container_ip() {
    local container="${1}";
    local default="${2}";

    local host="$(docker inspect --format '{{.NetworkSettings.IPAddress}}' "${container}" || echo "${default}")";

    local host="$( echo -e "${host}" | tr -d "[:space:]" )";
    local host="$([ ${#host} -le 0 ] && echo "${default}" || echo "${host}")";
    local host="$( echo -e "${host}" | tr -d "[:space:]" )";

    echo "${host}";
}
export -f docker_container_ip;

docker_network_preferred() {
    local os="$(user_os)"

    case "${os}" in
      *"OSX"*)    echo "bridge" ;;
      *"LINUX"*)  echo "host" ;;
      *)        echo "unknown: ${OSTYPE}" ;;
    esac
}
export -f docker_network_preferred;

docker_socket_enable() {
    sudo chmod 666 /var/run/docker.sock;
}
export -f docker_container_ip;

