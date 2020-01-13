#@IgnoreInspection BashAddShebang
ARG PARENT_VERSION="19.10"
FROM ehrlichandreas/workbase-ubuntu:${PARENT_VERSION}
LABEL maintainer="Andreas Ehrlich <ehrlich.andreas@googlemail.com>"

SHELL ["/bin/bash", "-c"]

COPY ./copy /tmp

RUN set -eux; \
export DEBIAN_FRONTEND=noninteractive && \
export APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn && \
export TERM=xterm-256color && \
\
apt-install-from-file.sh /tmp/apt-dependencies && \
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu cosmic stable" && \
apt-install-from-file.sh /tmp/docker-dependencies && \
\
dockerd -v; \
docker -v; \
docker-compose --version; \
\
curl -fL https://raw.githubusercontent.com/docker/docker-ce/master/components/cli/contrib/completion/bash/docker \
    -o /etc/bash_completion.d/docker; \
curl -fL https://raw.githubusercontent.com/docker/compose/master/contrib/completion/bash/docker-compose \
    -o /etc/bash_completion.d/docker-compose && \
\
touch /var/run/docker.sock && \
chmod 666 /var/run/docker.sock && \
\
bash /tmp/user-create-sudo.sh docker 1000 1000 && \
\
rm -rf /tmp/*

#groupadd 1000 || true; \
#useradd "docker" \
#    --create-home \
#    --uid 1000 \
#    --gid 1000 \
#    --non-unique \
#    || true; \
#groupadd "docker" || true; \
#usermod -a -G "docker" "docker" || true; \
#usermod -a -G "root" "docker" || true; \
#usermod -a -G "sudo" "docker" || true

#VOLUME /var/run/docker.sock
VOLUME /var/lib/docker

ENTRYPOINT []
CMD ["bash"]
