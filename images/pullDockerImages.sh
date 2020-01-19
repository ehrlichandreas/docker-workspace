#!/usr/bin/env bash

pull_docker_images() {
    local domain="docker.io";

    local images="\
        ehrlichandreas/workbase-ubuntu:19.10 \
        ehrlichandreas/workbase-ubuntu:latest \
        ehrlichandreas/workbase-dind:19.03.5 \
        ehrlichandreas/workbase-dind:latest \
        ehrlichandreas/workbase-python:3.7.5 \
        ehrlichandreas/workbase-python:latest \
        ehrlichandreas/workbase-aws-cli:1.16.314 \
        ehrlichandreas/workbase-aws-cli:latest \
        ehrlichandreas/workbase-terraform:0.12.19 \
        ehrlichandreas/workbase-terraform:latest \
        ehrlichandreas/workbase-environment:2019.0.1 \
        ehrlichandreas/workbase-environment:latest \
        ehrlichandreas/workbase-ide-base:2019.0.1 \
        ehrlichandreas/workbase-ide-base:latest \
        ehrlichandreas/workbase-intellij-idea:u-2019.3.1 \
        ehrlichandreas/workbase-intellij-idea:latest \
        ehrlichandreas/workbase-lyx:2.3.3 \
        ehrlichandreas/workbase-lyx:latest \
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
