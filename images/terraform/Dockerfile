#@IgnoreInspection BashAddShebang
ARG PARENT_VERSION="1.16"

FROM ehrlichandreas/workbase-aws-cli:$PARENT_VERSION
LABEL maintainer="Andreas Ehrlich <ehrlich.andreas@googlemail.com>"

SHELL ["/bin/bash", "-c"]

COPY ./copy /tmp

ARG TERRAFORM_VERSION="0.12.19"
ENV TERRAFORM_VERSION $TERRAFORM_VERSION

RUN set -eux; \
export DEBIAN_FRONTEND=noninteractive && \
export APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn && \
export TERM=xterm-256color && \
\
apt-install-from-file.sh /tmp/apt-dependencies && \
bash /tmp/auto-update-terraform.sh /usr/local/bin ${TERRAFORM_VERSION} && \
\
rm -rf /tmp/*

ENTRYPOINT ["terraform"]
CMD []
