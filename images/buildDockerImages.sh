#!/usr/bin/env bash

_THIS_DIR="$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)";

cd "${_THIS_DIR}";
cd "ubuntu";
bash buildDockerImage.sh;

cd "${_THIS_DIR}";
cd "docker-in-docker";
bash buildDockerImage.sh;

cd "${_THIS_DIR}";
cd "python";
bash buildDockerImage.sh;

cd "${_THIS_DIR}";
cd "aws-cli";
bash buildDockerImage.sh;

cd "${_THIS_DIR}";
cd "terraform";
bash buildDockerImage.sh;

cd "${_THIS_DIR}";
cd "environment";
bash buildDockerImage.sh;

cd "${_THIS_DIR}";
cd "intellij-idea-u";
bash buildDockerImage.sh;

cd "${_THIS_DIR}";
cd "lyx";
bash buildDockerImage.sh;
