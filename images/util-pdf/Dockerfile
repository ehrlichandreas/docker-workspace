#@IgnoreInspection BashAddShebang
ARG PARENT_VERSION="19.10"
FROM ehrlichandreas/workbase-util-imagemagick:${PARENT_VERSION}
LABEL maintainer="Andreas Ehrlich <ehrlich.andreas@googlemail.com>"

SHELL ["/bin/bash", "-c"]

COPY ./copy /tmp

RUN set -eux; \
export DEBIAN_FRONTEND=noninteractive && \
export APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn && \
export TERM=xterm-256color && \
\
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 20D0BB61B700CE29 && \
add-apt-repository "deb http://ppa.launchpad.net/malteworld/ppa/ubuntu cosmic main" && \
apt-install-from-file.sh "/tmp/apt-dependencies" && \
fc-cache -f -v && \
\
rm -rf /tmp/*

ENTRYPOINT []
CMD []
