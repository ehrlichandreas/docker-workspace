#!/usr/bin/env bash

git_library_import() {
    local _THIS_DIR=$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P);
    source "${_THIS_DIR}/basic.sh" &>/dev/null || source "./basic.sh" &>/dev/null;
}
git_library_import;

git_signature_use() {
    echo "1";
}
export -f git_signature_use;

git_diff_summary() {
    local diff="$( git diff --numstat "${@}" \
        | awk '{ added += $1; removed += $2 } END { print "+" added " -" removed }' )";
    local length="${#diff}";

    if [[ ${length} == 3 ]]
    then
        local diff="$( git diff --numstat --cached "${@}" \
            | awk '{ added += $1; removed += $2 } END { print "+" added " -" removed }' )";
    fi;

    echo "${diff}";
}
export -f git_diff_summary;

git_branch_current() {
    git rev-parse --abbrev-ref HEAD;
}
export -f git_branch_current;

git_branch_delete() {
    local branches="$( echo -e "${@}" | \
        sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' )" && \
    local array=(${branches// / }) && \
        \
    local i=0 && \
    for i in "${!array[@]}"
    do {
        local branch="${array[i]}";
        git push --force origin --delete "${branch}";
        git branch -D --force "${branch}";
    }
    done
}
export -f git_branch_delete;

git_branch_merge() {
    local current_working_dir="$( pwd )" && \
        \
    local branchFrom="${1}" && \
    local branchTo="${2}" && \
    local useSignature="$( git_signature_use )" && \
    local signature="" && \
        \
    if [[ "${useSignature}" == "1" ]]
    then {
        local signature="-S";
    }
    fi
        \
    git fetch --all && \
        \
    git checkout "${branchFrom}" && \
    git merge --ff-only && \
        \
    git checkout "${branchTo}" && \
    git merge --ff-only && \
        \
    git merge "${signature}" --no-ff "${branchFrom}" && \
        \
    cd "${current_working_dir}";
}
export -f git_branch_merge;
