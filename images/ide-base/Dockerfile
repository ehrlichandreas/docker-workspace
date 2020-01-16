#@IgnoreInspection BashAddShebang
ARG PARENT_VERSION="19.10"

FROM ehrlichandreas/workbase-dind:${PARENT_VERSION}
LABEL maintainer="Andreas Ehrlich <ehrlich.andreas@googlemail.com>"

SHELL ["/bin/bash", "-c"]

#jdk
COPY --chown=root:docker --from="openjdk:8u232-jdk-slim" "/usr/local/openjdk-8" "/opt/apps/openjdk-8"
COPY --chown=root:docker --from="openjdk:11.0.5-jdk-slim" "/usr/local/openjdk-11" "/opt/apps/openjdk-11"
COPY --chown=root:docker --from="openjdk:13.0.1-jdk-slim" "/usr/java/openjdk-13" "/opt/apps/openjdk-13"
COPY --chown=root:docker --from="openjdk:14-jdk-slim" "/usr/java/openjdk-14" "/opt/apps/openjdk-14"
COPY --chown=root:docker --from="openjdk:15-jdk-slim" "/usr/java/openjdk-15" "/opt/apps/openjdk-15"
#ant
COPY --chown=root:docker --from="frekele/ant:1.10.3-jdk8" "/opt/ant" "/opt/apps/apache-ant-1.10.3"
#maven
COPY --chown=root:docker --from="maven:3.5.2-jdk-8-slim" "/usr/share/maven" "/opt/apps/apache-maven-3.5.2"
COPY --chown=root:docker --from="maven:3.6.3-jdk-8-slim" "/usr/share/maven" "/opt/apps/apache-maven-3.6.3"
#node
COPY --chown=root:docker --from="node:12.14.1-slim" "/usr/local/bin" "/opt/apps/node-12.14.1/bin"
COPY --chown=root:docker --from="node:12.14.1-slim" "/usr/local/lib" "/opt/apps/node-12.14.1/lib"
COPY --chown=root:docker --from="node:12.14.1-slim" "/opt/yarn-v1.21.1" "/opt/apps/yarn-1.21.1"
COPY --chown=root:docker --from="node:13.6.0-slim" "/usr/local/bin" "/opt/apps/node-13.6.0/bin"
COPY --chown=root:docker --from="node:13.6.0-slim" "/usr/local/lib" "/opt/apps/node-13.6.0/lib"

COPY ./copy /tmp

RUN set -eux; \
export DEBIAN_FRONTEND=noninteractive && \
export APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn && \
export TERM=xterm-256color && \
\
apt-install-from-file.sh /tmp/apt-dependencies && \
\
rm -rf /tmp/* && \
\
export JAVA_HOME="/opt/apps/openjdk-8" && \
update-alternatives --install "/usr/local/bin/java" "java" "${JAVA_HOME}/bin/java" 1 && \
update-alternatives --set "java" "${JAVA_HOME}/bin/java" && \
update-alternatives --install "/usr/local/bin/javac" "javac" "${JAVA_HOME}/bin/javac" 1 && \
update-alternatives --set "javac" "${JAVA_HOME}/bin/javac" && \
update-alternatives --install "/usr/local/bin/javaw" "javaw" "${JAVA_HOME}/bin/javaw" 1 || echo "javaw not found" && \
update-alternatives --set "javaw" "${JAVA_HOME}/bin/javaw" || echo "javaw not found" && \
update-alternatives --install "/usr/local/bin/javaws" "javaws" "${JAVA_HOME}/bin/javaws" 1 || echo "javaws not found" && \
update-alternatives --set "javaws" "${JAVA_HOME}/bin/javaws" || echo "javaws not found" && \
\
export ANT_HOME="/opt/apps/apache-ant-1.10.3" && \
update-alternatives --install "/usr/local/bin/ant" "ant" "${ANT_HOME}/bin/ant" 1 && \
update-alternatives --set "ant" "${ANT_HOME}/bin/ant" && \
\
export MAVEN_HOME="/opt/apps/apache-maven-3.5.2" && \
update-alternatives --install "/usr/local/bin/mvn" "mvn" "${MAVEN_HOME}/bin/mvn" 1 && \
update-alternatives --set "mvn" "${MAVEN_HOME}/bin/mvn" && \
update-alternatives --install "/usr/local/bin/mvnDebug" "mvnDebug" "${MAVEN_HOME}/bin/mvnDebug" 1 || echo "mvnDebug not found" && \
update-alternatives --set "mvnDebug" "${MAVEN_HOME}/bin/mvnDebug" || echo "mvnDebug not found" && \
update-alternatives --install "/usr/local/bin/mvnyjp" "mvnyjp" "${MAVEN_HOME}/bin/mvnyjp" 1 || echo "mvnyjp not found" && \
update-alternatives --set "mvnyjp" "${MAVEN_HOME}/bin/mvnyjp" || echo "mvnyjp not found" && \
\
export YARN_HOME="/opt/apps/yarn-1.21.1" && \
export NODE_HOME="/opt/apps/node-12.14.1" && \
cd "${NODE_HOME}/bin" && \
rm "${NODE_HOME}/bin/nodejs" && \
ln -s node nodejs && \
rm "${NODE_HOME}/bin/yarn" && \
ln -s "${YARN_HOME}/bin/yarn" yarn && \
rm "${NODE_HOME}/bin/yarnpkg" && \
ln -s "${YARN_HOME}/bin/yarnpkg" yarnpkg && \
\
export YARN_HOME="/opt/apps/yarn-1.21.1" && \
export NODE_HOME="/opt/apps/node-13.6.0" && \
cd "${NODE_HOME}/bin" && \
rm "${NODE_HOME}/bin/nodejs" && \
ln -s node nodejs && \
rm "${NODE_HOME}/bin/yarn" && \
ln -s "${YARN_HOME}/bin/yarn" yarn && \
rm "${NODE_HOME}/bin/yarnpkg" && \
ln -s "${YARN_HOME}/bin/yarnpkg" yarnpkg && \
\
export NODE_HOME="/opt/apps/node-12.14.1" && \
update-alternatives --install "/usr/local/bin/node" "node" "${NODE_HOME}/bin/node" 1 && \
update-alternatives --set "node" "${NODE_HOME}/bin/node" && \
update-alternatives --install "/usr/local/bin/nodejs" "nodejs" "${NODE_HOME}/bin/nodejs" 1 && \
update-alternatives --set "nodejs" "${NODE_HOME}/bin/nodejs" && \
update-alternatives --install "/usr/local/bin/npm" "npm" "${NODE_HOME}/bin/npm" 1 && \
update-alternatives --set "npm" "${NODE_HOME}/bin/npm" && \
update-alternatives --install "/usr/local/bin/npx" "npx" "${NODE_HOME}/bin/npx" 1 && \
update-alternatives --set "npx" "${NODE_HOME}/bin/npx" && \
\
export YARN_HOME="/opt/apps/yarn-1.21.1" && \
update-alternatives --install "/usr/local/bin/yarn" "yarn" "${YARN_HOME}/bin/yarn" 1 && \
update-alternatives --set "yarn" "${YARN_HOME}/bin/yarn" && \
update-alternatives --install "/usr/local/bin/yarnpkg" "yarnpkg" "${YARN_HOME}/bin/yarnpkg" 1 && \
update-alternatives --set "yarnpkg" "${YARN_HOME}/bin/yarnpkg"

ENTRYPOINT []
CMD ["/opt/idea/bin/idea-starter.sh"]
