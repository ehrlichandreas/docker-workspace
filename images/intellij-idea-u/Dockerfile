#@IgnoreInspection BashAddShebang
ARG PARENT_VERSION="2019.0.1"

FROM ehrlichandreas/workbase-ide-base:${PARENT_VERSION}
LABEL maintainer="Andreas Ehrlich <ehrlich.andreas@googlemail.com>"

SHELL ["/bin/bash", "-c"]

COPY ./copy /tmp

ARG IDEA_VERSION="2019.3.1"
ARG IDEA_SOURCE="https://download.jetbrains.com/idea/ideaIU-${IDEA_VERSION}.tar.gz"
ARG IDEA_LOCAL_DIR=".IntelliJIdeaU"

RUN set -eux; \
export DEBIAN_FRONTEND=noninteractive && \
export APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn && \
export TERM=xterm-256color && \
\
mkdir /opt/idea && \
curl -fksSL "${IDEA_SOURCE}" -o "/opt/idea/installer.tgz" && \
cd /opt/idea && \
tar --strip-components=1 -xzf installer.tgz && \
rm /opt/idea/installer.tgz && \
\
mv /tmp/idea.properties /opt/idea/bin/idea.properties && \
mv /tmp/idea.vmoptions /opt/idea/bin/idea.vmoptions && \
mv /tmp/idea64.vmoptions /opt/idea/bin/idea64.vmoptions && \
mv /tmp/idea-starter.sh /opt/idea/bin/idea-starter.sh && \
chmod +x /opt/idea/bin/idea-starter.sh && \
\
rm -rf /tmp/* && \
chown -Rf root:docker /opt/idea/* && \
\
mkdir "/home/docker/.IntelliJIdea" && \
ln -sf "/home/docker/.IntelliJIdea" "/home/docker/${IDEA_LOCAL_DIR}"
#touch "/etc/sysctl.d/jetbrains.conf" && \
#echo "fs.inotify.max_user_watches = 1048576" > "/etc/sysctl.d/jetbrains.conf"

ENTRYPOINT []
CMD ["/opt/idea/bin/idea-starter.sh"]
