#@IgnoreInspection BashAddShebang
ARG PARENT_REPOSITORY="terraform"
ARG PARENT_VERSION="0.12"

FROM ${PARENT_REPOSITORY}:${PARENT_VERSION}
LABEL maintainer="Andreas Ehrlich <ehrlich.andreas@googlemail.com>"

ENV \
DEBIAN_FRONTEND=noninteractive \
APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn \
TERM=xterm-256color

ENTRYPOINT []
CMD ["bash"]
