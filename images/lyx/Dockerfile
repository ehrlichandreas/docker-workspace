#@IgnoreInspection BashAddShebang
ARG PARENT_REPOSITORY="ubuntu"
ARG PARENT_VERSION="19.10"

FROM ${PARENT_REPOSITORY}:${PARENT_VERSION}
LABEL maintainer="Andreas Ehrlich <ehrlich.andreas@googlemail.com>"

SHELL ["/bin/bash", "-c"]

COPY ./copy /tmp

RUN set -eux; \
export DEBIAN_FRONTEND=noninteractive && \
export APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn && \
export TERM=xterm-256color && \
\
apt-install-from-file.sh /tmp/apt-dependencies && \
\
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys A64833C9F8214ACD && \
add-apt-repository "deb http://ppa.launchpad.net/lyx-devel/release/ubuntu focal main" && \
add-apt-repository "deb http://archive.ubuntu.com/ubuntu/ bionic main universe" && \
add-apt-repository "deb http://archive.ubuntu.com/ubuntu/ focal main multiverse" && \
apt-get -y update && \
\
echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | sudo debconf-set-selections && \
apt-install-from-file.sh /tmp/lyx-dependencies && \
fc-cache -f -v && \
\
rm -rf /tmp/*

ENV QT_X11_NO_MITSHM=1

ENTRYPOINT []
CMD ["lyx"]
