#!/usr/bin/env bash

###
#  basic operations
###
array_contains_element () {
    local list="$( echo -e "${1}" | \
        sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' )" && \
    local array=(${list// / }) && \
    local match="$( echo -e "${2}" | \
        sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' )" && \
        \
    local i=0 && \
    for i in "${!array[@]}"
    do {
        local element="${array[i]}" && \
            \
        if [[ "${element}" == "${match}" ]]
        then {
            echo 1;
            return;
        }
        fi
    }
    done && \
        \
    echo 0;
}
export -f array_contains_element;

compare_version () {
    if [[ "${1}" == "${2}" ]]
    then
        echo 0;
        return;
    fi
    local IFS=.
    local i ver1=("${1}") ver2=("${2}")
    # fill empty fields in ver1 with zeros
    for ((i=${#ver1[@]}; i<${#ver2[@]}; i++))
    do
        ver1[i]=0
    done
    for ((i=0; i<${#ver1[@]}; i++))
    do
        if [[ -z ${ver2[i]} ]]
        then
            # fill empty fields in ver2 with zeros
            ver2[i]=0
        fi
        if ((10#${ver1[i]} > 10#${ver2[i]}))
        then
            echo 1;
            return;
        fi
        if ((10#${ver1[i]} < 10#${ver2[i]}))
        then
            echo 2;
            return;
        fi
    done
    echo 0;
    return;
}
export -f compare_version;

directory_current() {
    SOURCE="$0";
    while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
      DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )";
      SOURCE="$(readlink "$SOURCE")";
      [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"; # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
    done
    DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )";
    DIR="$( realpath ${DIR} )";

    echo ${DIR};
}
export -f directory_current;

dns_by_resolv() {
    local default="${1}";
    local host="";

    local host="$(cat "/etc/resolv.conf"  | grep -v '^#' | grep "nameserver" | awk '{print $2}' | head -n 1)"

    local host="$( echo -e "${host}" | tr -d "[:space:]" )";
    local host="$([[ "${#host}" -le 0 ]] && echo "${default}" || echo "${host}")";
    local host="$( echo -e "${host}" | tr -d "[:space:]" )";

    if [[ "${host}" == "127.0.1.1" ]]; then
        local host="${default}";
    fi

    local host="$( echo -e "${host}" | tr -d "[:space:]" )";

    echo "${host}";
}
export -f dns_by_resolv;

dns_by_nmcli() {
    local default="${1}";
    local host="";

    if [[ "$(command -v "nmcli" | wc -l)" -gt 0 ]]
    then
        local host="$(nmcli dev show | grep DNS | awk '{print $2}' | head -n 1)";
    else
        local host="127.0.1.1";
    fi;

    local host="$( echo -e "${host}" | tr -d "[:space:]" )";
    local host="$([[ "${#host}" -le 0 ]] && echo "${default}" || echo "${host}")";
    local host="$( echo -e "${host}" | tr -d "[:space:]" )";

    if [[ "${host}" == "127.0.1.1" ]]; then
        local host="${default}";
    fi

    local host="$( echo -e "${host}" | tr -d "[:space:]" )";

    echo "${host}";
}
export -f dns_by_nmcli;

escape() {
    echo "$1" | sed -e 's/[]\/$*.^|[]/\\&/g';
}
export -f escape;

find_all_subdirectories() {
    find $1 -type d -print 2>/dev/null;
}
export -f find_all_subdirectories;

find_environment_variables() {
    local patternDefault=".*";

    local input="${@}";
    local input=(${input// / });

    local pattern="$([[ ${#input[@]} -le 0 ]] && echo "" || \
        echo "${input[-1]}")";
    local pattern="$([[ "${#pattern}" -le 0 ]] && echo "${patternDefault}" || \
        echo "${pattern}")";

    local variables="$(
            compgen -A variable \
                | grep "${pattern}" \
                | sort -u \
                | tr '\n' ' ' \
       )";
    local variables="$( echo -e "${variables}" | \
            sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' )";

    echo "${variables}";
}
export -f find_environment_variables;

list_clean() {
    local list="$( echo -e "${@}" | \
        sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' | \
        xargs -n1 | sort -u | xargs | sed -e 's/\(.*\)/\L\1/' )" && \
    echo "${list}";
}
export -f list_clean;

path_clean() {
    echo $1 | tr ':' '\n' | sed '/^[[:space:]]*$/d' | sort -u | tr '\n' ':' | sed 's/:$//'
}
export -f path_clean;

timestamp() {
    date "+%s";
}
export -f timestamp;

throw_exception() {
    echo "${@}";
}
export -f throw_exception;

throw_exception_exit() {
    throw_exception "${@}";
    exit 1;
}
export -f throw_exception_exit;

user_home() {
    if [[ "$(command -v "getent" | wc -l)" -gt 0 ]]
    then
        echo "$(getent passwd "$(whoami)" | cut -d: -f6)";
    elif [[ "$(command -v finger | wc -l)" -gt 0 ]]
    then
        echo "$(finger "$(whoami)" | awk '/^Directory/ {print $2}')";
    fi;
}
export -f user_home;

user_os() {
    local os="${OSTYPE//[0-9.-]*/}";

    case "${os}" in
      *solaris*)    echo "SOLARIS" ;;
      *darwin*)     echo "OSX" ;;
      *linux*)      echo "LINUX" ;;
      *bsd*)        echo "BSD" ;;
      *msys*)       echo "WINDOWS" ;;
      *)            echo "unknown: ${OSTYPE}" ;;
    esac
}
export -f user_os;

