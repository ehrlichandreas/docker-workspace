#@IgnoreInspection BashAddShebang
ARG PARENT_REPOSITORY="util-base"
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
add-apt-repository ppa:rolfbensch/sane-git && \
apt-install-from-file.sh "/tmp/apt-dependencies" && \
\
export BINDIR="/usr/local/bin" && \
mv "/tmp/scanimage-to-file.sh" "${BINDIR}/scanimage-to-file.sh" && \
chmod -Rf 755 "${BINDIR}/scanimage-to-file.sh" && \
ls -la ${BINDIR}/scanimage-to-file.sh && \
update-alternatives --install "${BINDIR}/scanimage-to-file" "scanimage-to-file" "${BINDIR}/scanimage-to-file.sh" 1 && \
update-alternatives --set "scanimage-to-file" "${BINDIR}/scanimage-to-file.sh" && \
\
rm -rf /tmp/*

ENTRYPOINT []
CMD []
