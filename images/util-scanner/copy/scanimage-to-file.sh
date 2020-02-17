#!/usr/bin/env bash

scanimage_to_file() {
    local device="${1}";
    local mode="${2}";
    local resolution="${3}";
    local format="${4}";
    local fileName="${5}";

    #    --device "${device}" \

    scanimage \
        --progress \
        --buffer-size=1M \
        --verbose \
        -x 210 \
        -y 297 \
        --mode "${mode}" \
        --resolution "${resolution}" \
        --format "${format}" \
            > "${fileName}";
}

scanimage_to_file "${@}";
