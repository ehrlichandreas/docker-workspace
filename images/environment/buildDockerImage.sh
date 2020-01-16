#!/usr/bin/env bash

_THIS_DIR="$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)";

cd "${_THIS_DIR}";

NOCACHE=false;
DOCKERFILE="Dockerfile";
REPOSITORY="ehrlichandreas/workbase-environment";
VERSION="2019.0.1";
PARENT_VERSION="0.12.19";
IMAGE_NAME="${REPOSITORY}:${VERSION}";

DOCKER_VERSION="${VERSION}";

BUILD_START="$(date '+%s')";

{
    docker build \
        --network=host \
        --force-rm=${NOCACHE} \
        --no-cache=${NOCACHE} \
        --build-arg PARENT_VERSION=${PARENT_VERSION} \
        --build-arg DOCKER_VERSION=${DOCKER_VERSION} \
        -t "${IMAGE_NAME}" \
        -t "${REPOSITORY}:latest" \
        -f "${DOCKERFILE}" \
        "${_THIS_DIR}";
} || \
{
  echo "There was an error building the image."
  exit 1
}

BUILD_END="$(date '+%s')";
BUILD_ELAPSED="$(expr ${BUILD_END} - ${BUILD_START})";

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
