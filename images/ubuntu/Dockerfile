#@IgnoreInspection BashAddShebang
ARG PARENT_VERSION="19.10"

FROM ubuntu:${PARENT_VERSION}
LABEL maintainer="Andreas Ehrlich <ehrlich.andreas@googlemail.com>"

COPY ./copy /tmp

RUN set -eux; \
export DEBIAN_FRONTEND=noninteractive && \
export APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn && \
export TERM=xterm-256color && \
\
mv /tmp/apt-install.sh /usr/local/bin/apt-install.sh && \
chmod 755 /usr/local/bin/apt-install.sh && \
mv /tmp/apt-install-from-file.sh /usr/local/bin/apt-install-from-file.sh && \
chmod 755 /usr/local/bin/apt-install-from-file.sh && \
\
apt-install-from-file.sh "tmp/apt-dependencies" && \
\
rm -rf /tmp/*;
