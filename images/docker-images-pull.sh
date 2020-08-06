#!/usr/bin/env bash

pull_docker_images() {
    local domain="docker.io";

    local _THIS_DIR="$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)";

    cd "${_THIS_DIR}";

    source "${_THIS_DIR}/config.sh" &>/dev/null;
    source "./config.sh" &>/dev/null;

    local images="\
        ${awscli_repository}:${awscli_repo_version} \
        ${awscli_repository}:latest \
        ${docker_repository}:${docker_repo_version} \
        ${docker_repository}:latest \
        ${environment_repository}:${environment_repo_version} \
        ${environment_repository}:latest \
        ${ide_base_repository}:${ide_base_repo_version} \
        ${ide_base_repository}:latest \
        ${intellij_idea_c_repository}:${intellij_idea_c_repo_version} \
        ${intellij_idea_c_repository}:latest \
        ${intellij_idea_u_repository}:${intellij_idea_u_repo_version} \
        ${intellij_idea_u_repository}:latest \
        ${lyx_repository}:${lyx_repo_version} \
        ${lyx_repository}:latest \
        ${python_repository}:${python_repo_version} \
        ${python_repository}:latest \
        ${terraform_repository}:${terraform_repo_version} \
        ${terraform_repository}:latest \
        ${ubuntu_repository}:${ubuntu_repo_version} \
        ${ubuntu_repository}:latest \
        ${util_base_repository}:${util_base_version} \
        ${util_base_repository}:latest \
        ${util_imagemagick_repository}:${util_imagemagick_version} \
        ${util_imagemagick_repository}:latest \
        ${util_pdf_repository}:${util_pdf_version} \
        ${util_pdf_repository}:latest \
        ${util_scanner_repository}:${util_scanner_version} \
        ${util_scanner_repository}:latest \
    "

    for image in ${images};
    do {
        docker pull "${image}";

        #docker pull "${domain}/${image}";
        #docker tag "${domain}/${image}" "${image}";
        #docker rmi "${domain}/${image}";
    }
    done;
}

pull_docker_images "$@";
