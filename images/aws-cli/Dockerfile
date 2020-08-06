#@IgnoreInspection BashAddShebang
ARG PARENT_REPOSITORY="python"
ARG PARENT_VERSION="3.7"

FROM ${PARENT_REPOSITORY}:${PARENT_VERSION}
LABEL maintainer="Andreas Ehrlich <ehrlich.andreas@googlemail.com>"

SHELL ["/bin/bash", "-c"]

COPY ./copy /tmp

RUN set -eux; \
export DEBIAN_FRONTEND=noninteractive && \
export APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn && \
export TERM=xterm-256color && \
\
pip3-install-from-file.sh /tmp/pip3-dependencies && \
cp -f /usr/local/bin/aws_bash_completer /etc/bash_completion.d/aws-cli && \
\
rm -rf /tmp/*

ENTRYPOINT ["aws"]
CMD []
