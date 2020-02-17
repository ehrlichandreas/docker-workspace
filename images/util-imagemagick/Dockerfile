#@IgnoreInspection BashAddShebang
ARG PARENT_VERSION="19.10"
FROM ehrlichandreas/workbase-util-base:${PARENT_VERSION}
LABEL maintainer="Andreas Ehrlich <ehrlich.andreas@googlemail.com>"

SHELL ["/bin/bash", "-c"]

COPY ./copy /tmp

RUN set -eux; \
export DEBIAN_FRONTEND=noninteractive && \
export APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn && \
export TERM=xterm-256color && \
\
#apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 20D0BB61B700CE29 && \
#add-apt-repository "deb http://ppa.launchpad.net/malteworld/ppa/ubuntu cosmic main" && \
#add-apt-repository "deb http://archive.ubuntu.com/ubuntu/ disco multiverse" && \
echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | sudo debconf-set-selections && \
apt-install-from-file.sh "/tmp/apt-dependencies" && \
fc-cache -f -v && \
\
policyFile="$(identify -list policy | grep "/etc/"  | awk '{print $2}')" && \
policyContent="$( \
cat "${policyFile}" | \
sed 's/domain="resource" name="memory" value=".*"/domain="resource" name="memory" value="3GB"/g' | \
sed 's/domain="resource" name="disk" value=".*"/domain="resource" name="disk" value="12GB"/g' | \
sed 's/domain="resource" name="map" value=".*"/domain="resource" name="map" value="6GB"/g' | \
sed 's/domain="resource" name="area" value=".*"/domain="resource" name="area" value="3GB"/g' | \
sed 's/domain="resource" name="width" value=".*"/domain="resource" name="width" value="192KP"/g' | \
sed 's/domain="resource" name="height" value=".*"/domain="resource" name="height" value="192KP"/g' | \
sed 's/domain="coder" rights="none"/domain="coder" rights="read|write"/g' \
)" && \
printf "${policyContent}" | tee "${policyFile}" && \
\
rm -rf /tmp/*

ENTRYPOINT []
CMD []
