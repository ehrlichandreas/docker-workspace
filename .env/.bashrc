## basic bashrc
source ~/.bashrc.shared

#_THIS_DIR=$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P);

source ~/basic.sh
source ~/docker.sh
source ~/documentation.sh
source ~/git.sh
source ~/imagemagick.sh
source ~/ocr.sh
source ~/pdf.sh
source ~/scan.sh

alias aws_docker_login="bash -c '$(aws ecr get-login | sed 's/\s\-e\s\w*//g')'"
