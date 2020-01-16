## basic bashrc
source ~/.bashrc.shared

source ~/git.sh

alias aws_docker_login="bash -c '$(aws ecr get-login | sed 's/\s\-e\s\w*//g')'"
