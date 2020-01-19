#!/usr/bin/env bash

build_docker_image() {
    local _THIS_DIR="$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)";

    cd "${_THIS_DIR}";

    local NOCACHE=false;
    local DOCKERFILE="Dockerfile";
    local REPOSITORY="ehrlichandreas/workbase-aws-cli";
    local VERSION="1.16.314";
    local PARENT_VERSION="3.7.5";
    local IMAGE_NAME="${REPOSITORY}:${VERSION}";

    local BUILD_START="$(date '+%s')";

    {
        docker build \
            --network=host \
            --force-rm=${NOCACHE} \
            --no-cache=${NOCACHE} \
            --build-arg PARENT_VERSION=${PARENT_VERSION} \
            -t "${IMAGE_NAME}" \
            -t "${REPOSITORY}:latest" \
            -f "${DOCKERFILE}" \
            "${_THIS_DIR}";
    } || \
    {
        echo "There was an error building the image."
        exit 1
    }

    local BUILD_END="$(date '+%s')";
    local BUILD_ELAPSED="$(expr ${BUILD_END} - ${BUILD_START})";

    echo "";

    if [[ $? -eq 0 ]]; then
        cat << EOF
Docker Image for '${REPOSITORY}' version ${VERSION} is ready to be extended:

--> ${IMAGE_NAME}

Build completed in ${BUILD_ELAPSED} seconds.

EOF
    else
        echo "${REPOSITORY} Docker Image was NOT successfully created. Check the output and correct any reported problems with the docker build operation."
    fi
}

build_docker_image "$@";
