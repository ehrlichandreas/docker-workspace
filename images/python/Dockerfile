#@IgnoreInspection BashAddShebang
ARG PARENT_VERSION="19.03"

FROM ehrlichandreas/workbase-dind:${PARENT_VERSION}
LABEL maintainer="Andreas Ehrlich <ehrlich.andreas@googlemail.com>"

SHELL ["/bin/bash", "-c"]

COPY ./copy /tmp

# ensure local python is preferred over distribution python
ENV PATH /usr/local/bin:$PATH

# http://bugs.python.org/issue19846
# > At the moment, setting "LANG=C" on a Linux system *fundamentally breaks Python 3*, and that's not OK.
ENV LANG C.UTF-8

RUN set -eux; \
export DEBIAN_FRONTEND=noninteractive && \
export APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn && \
export TERM=xterm-256color && \
\
mv /tmp/pip3-install.sh /usr/local/bin/pip3-install.sh && \
chmod 755 /usr/local/bin/pip3-install.sh && \
mv /tmp/pip3-install-from-file.sh /usr/local/bin/pip3-install-from-file.sh && \
chmod 755 /usr/local/bin/pip3-install-from-file.sh && \
\
curl -fksSL https://bootstrap.pypa.io/get-pip.py -o /tmp/get-pip.py && \
apt-install-from-file.sh /tmp/apt-dependencies && \
python3 /tmp/get-pip.py && \
pip3-install-from-file.sh /tmp/pip3-dependencies && \
\
rm -rf /tmp/*

ENTRYPOINT []
CMD ["python3"]
