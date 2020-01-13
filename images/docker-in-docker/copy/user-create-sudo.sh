#!/usr/bin/env bash

user_create_sudo() {
    local user=$1;
    local userId=$2;
    local groupId=$3;

    echo "# Creating user: ${user}" && \
        mkdir -p "/home/${user}" && \
        echo "${user}:x:${userId}:${groupId}:${user},,,:/home/${user}:/bin/bash" >> "/etc/passwd" && \
        echo "${user}:x:${groupId}:" >> "/etc/group" && \
        sudo echo "${user} ALL=(ALL) NOPASSWD: ALL" > "/etc/sudoers.d/${user}" && \
        sudo chmod 0440 "/etc/sudoers.d/${user}" && \
        sudo chown -Rf "${user}:${user}" /home/${user} && \
        sudo chown "root:root" "/usr/bin/sudo" && \
        chmod 4755 "/usr/bin/sudo" && \
    echo "# Created user: ${user}" && \
    \
    echo '# Edit sudoers file' && \
    echo '# To avoid error: sudo: sorry, you must have a tty to run sudo' && \
        sed -i -e 's/^\(Defaults\s*requiretty\)/#--- \1/'  /etc/sudoers  || true  && \
        echo "${user} ALL=(ALL) NOPASSWD: ALL" >> "/etc/sudoers" && \
    echo '# Edited sudoers file'
}

user_create_sudo "$@"
