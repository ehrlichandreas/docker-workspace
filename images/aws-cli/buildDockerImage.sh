#!/usr/bin/env bash

build_docker_image() {
    local _THIS_DIR="$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)";

    cd "${_THIS_DIR}";

    source "${_THIS_DIR}/../config.sh" &>/dev/null;
    source "./../config.sh" &>/dev/null;

    local NOCACHE=false;
    local DOCKERFILE="Dockerfile";
    local REPOSITORY="${awscli_repository}";
    local VERSION="${awscli_repo_version}";
    local PARENT_REPOSITORY="${awscli_parent_repository}";
    local PARENT_VERSION="${awscli_parent_version}";
    local IMAGE_NAME="${REPOSITORY}:${VERSION}";
    local IMAGE_NAME_LATEST="${REPOSITORY}:latest";

    local BUILD_START="$(date '+%s')";

    {
        docker build \
            --network=host \
            --force-rm=${NOCACHE} \
            --no-cache=${NOCACHE} \
            --build-arg PARENT_REPOSITORY=${PARENT_REPOSITORY} \
            --build-arg PARENT_VERSION=${PARENT_VERSION} \
            -t "${IMAGE_NAME}" \
            -t "${IMAGE_NAME_LATEST}" \
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
