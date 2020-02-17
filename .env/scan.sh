#!/usr/bin/env bash

scan_library_import() {
    local _THIS_DIR=$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P);
    source "${_THIS_DIR}/basic.sh" &>/dev/null \
        || source "./basic.sh" &>/dev/null;
    source "${_THIS_DIR}/docker.sh" &>/dev/null \
        || source "./docker.sh" &>/dev/null;
}
scan_library_import;

scan_docker_command() {
    local DOCKER_IMAGE_TAG="ehrlichandreas/workbase-util-scanner:2020.02.16";

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
export -f scan_docker_command;

scan_docker_connect() {
    local command="$@";

    if [[ $( docker_check_installed ) -eq 0 ]]
    then
        throw_exception_exit "docker not installed";
        return;
    fi

    if [[ "${#command}" -gt 0 ]];
    then
        scan_docker_command \
            /bin/bash --login -c \
            "${command}";
    else
        scan_docker_command \
            /bin/bash --login;
    fi
}
export -f scan_docker_connect;

scan_scanner_device() {
    if [[ $( docker_check_installed ) -eq 0 ]]
    then
        throw_exception_exit "docker not installed";
        return;
    fi

    #local deviceUri="$(scan_docker_command scanimage -L | awk '{print $2}' | head -n 1)" && \
    #local length="${#deviceUri}" && \
    #local device="${deviceUri:1:${length}-2}" && \
    #echo "${device}";
    local device="$(scan_docker_command scanimage --formatted-device-list=%d)";
    echo "${device}";
}
export -f scan_scanner_device;

scan_scanner_check() {
    if [[ $( docker_check_installed ) -eq 0 ]]
    then
        throw_exception_exit "docker not installed";
        return;
    fi

    local scanner="$(scan_scanner_device)" && \
    scan_docker_command scanimage -T;
}
export -f scan_scanner_check;

scan_scanner_save_image() {
    if [[ $( docker_check_installed ) -eq 0 ]]
    then
        throw_exception_exit "docker not installed";
        return;
    fi

    local device="${1}";
    local mode="${2}";
    local resolution="${3}";
    local format="${4}";
    local fileName="${5}";

    local command="";
    local command="${command} scanimage ";
    local command="${command} -p -v ";
    local command="${command} --device "${device}" ";
    local command="${command} --mode "${mode}" ";
    local command="${command} --resolution "${resolution}" ";
    local command="${command} --format "${format}" ";
    local command="${command} | tee "${fileName}" ";
    local command="${command}  ";

    #scan_docker_command "${command}";

    scan_docker_command scanimage-to-file.sh \
         "${device}" "${mode}" "${resolution}" "${format}" "${fileName}" && \
    echo "finished";
}
export -f scan_scanner_save_image;

scan_scanner_save_image_batch() {
    if [[ $( docker_check_installed ) -eq 0 ]]
    then
        throw_exception_exit "docker not installed";
        return;
    fi

    local input="${@}";
    local input=(${input// / });

    local numbers="";
    local strings="";

    local i=0;
    for i in "${!input[@]}"
    do
    {
        local parameter="${input[i]}";

        if [[ -n ${parameter//[0-9]/} ]]; then
            local strings="${strings} ${parameter}";
        else
            local numbers="${numbers} ${parameter}";
        fi
    }
    done

    local densityDefault="1200";
    local densityInput="${numbers[0]}";
    local densityInput="$([[ "${#densityInput}" -le 0 ]] && echo "${densityDefault}" || echo "${densityInput}")";

    local fileExtensionDefault="tiff";
    local fileExtension="${strings[0]}";
    local fileExtension="$([[ "${#fileExtension}" -le 0 ]] && echo "${fileExtensionDefault}" || echo "${fileExtension}")";

    local timestamp="$(timestamp)";
    local device="$(scan_scanner_device)";
    local mode="Color";
    local resolution="${densityInput}";
    local format="${fileExtension}";
    local fileNameScanner="${timestamp}.${format}";
    #local fileNameConverter="${timestamp}.jpg" &&
    scan_scanner_save_image "${device}" "${mode}" "${resolution}" "${format}" "${fileNameScanner}"
}
export -f scan_scanner_save_image_batch;

scan_scanner_save_image_batch2() {
    echo "" && echo "" && \
    scan_scanner_check && \
    echo "" && echo "" && \
    scan_scanner_save_image_batch && \
    echo "" && echo "";
}
export -f scan_scanner_save_image_batch2;
