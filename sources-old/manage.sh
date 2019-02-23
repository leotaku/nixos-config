#!/usr/bin/env bash

# input
BASEDIR="/etc/nixos/nixos-config/sources/links2"
DEFAULT_SOURCES_FILE="/etc/nixos/nixos-config/sources/sources"
DEFAULT_LOCK_FILE="/etc/nixos/nixos-config/sources/lock"
ACTION="${1}"
shift

# variables
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# functions

prefix () {
    read stdin
    if [[ -n "$stdin" ]]; then
        echo -e "${BLUE}${1}${NC}: ${stdin}"
    fi
}

prefix_lock () {
    read stdin
    if [[ -n "$stdin" ]]; then
        echo -e "${GREEN}locking ${1}${NC}: ${stdin}"
    fi
}

prefix_err () {
    read stdin
    if [[ -n "$stdin" ]]; then
        echo -e "${RED}error in ${1}${NC}: ${stdin}"
    fi
}

update () {
    cwd="$(pwd)"

    dir="$1"
    url="$2"
    branch="$3"
    upstream="$4"

    test -d "${BASEDIR}/${dir}" || {
        echo -e "path coresponding to source does not exist, creating it" | prefix "$dir"
        git clone "$url" "${BASEDIR}/${dir}" | prefix "$dir" || {
            echo "malformed entry or incorrect url" | prefix_err "$dir"
            return 1
        }
    }
    
    cd "${BASEDIR}/${dir}"

    [[ "${BASEDIR}/${dir}" = "$(pwd)" ]] || {
        echo -e "malformed entry - could not switch to dir" | prefix_err "$dir"
        return 1
    }

    if [[ -n "$(git status --porcelain)" ]]; then
        echo "worktree is dirty, aborting update" | prefix_err "$dir"
        return 1
    fi

    git reset --hard &>/dev/null #2>&1 | prefix "$dir"
    git clean -ffd &>/dev/null #2>&1 | prefix "$dir"

    if [[ -n "${upstream}" ]]; then
        git fetch "${upstream}" 2>&1 | prefix "$dir"
    fi

    run_controlled "git checkout ${branch}"

    git reset --hard &>/dev/null #2>&1 | prefix "$dir"
    git clean -ffd &>/dev/null #2>&1 | prefix "$dir"

    cd "$cwd"
}

run_controlled () {
    tmpfile="$(mktemp)"
    eval "${@}" &> "$tmpfile"
    if [[ "$?" == "0" ]]; then
        cat "$tmpfile" | prefix "$dir"
    else
        cat "$tmpfile" | prefix_err "$dir"
    fi
    rm "$tmpfile"
}

set_sources () {
    if [[ -n "$1" ]]; then
        SOURCES_FILE="$1"
    else
        SOURCES_FILE="$DEFAULT_SOURCES_FILE"
    fi
    SOURCES_UNSPLIT="$(cat $SOURCES_FILE)"
    IFS=$'\n'; SOURCES=($SOURCES_UNSPLIT); unset IFS;
}


update_all () {
    MATCH_PATH="$1"
    set_sources "$2"
    for fields_unsplit in "${SOURCES[@]}"; do
        {
            IFS=' ' read -ra fields <<< "$fields_unsplit"
            dir="${fields[0]}"
            url="${fields[1]}"
            branch="${fields[2]}"
            upstream="${fields[3]}"
            
            if [[ -z "$MATCH_PATH" ]] || [[ "$MATCH_PATH" == "." ]] || [[ "$dir" =~ "$MATCH_PATH" ]]; then
              update "$dir" "$url" "$branch" "$upstream"
            fi
      } &
    done
    wait
}

lock_all () {
    set_sources "$1"
    prepare_lock
    for fields_unsplit in "${SOURCES[@]}"; do
        IFS=' ' read -ra fields <<< "$fields_unsplit"
        dir="${fields[0]}"
        url="${fields[1]}"
        branch="${fields[2]}"
        upstream="${fields[3]}"
        
        cwd="$(pwd)"
        cd "${BASEDIR}/${dir}"
        [[ "${BASEDIR}/${dir}" = "$(pwd)" ]] || {
            echo -e "malformed or uninitialized entry - could not switch to dir" | prefix_err "$dir"
            return 1
        }

        lock_branch="$(git rev-parse ${branch})"
        cd "$cwd"

        echo "${dir} ${url} ${lock_branch} ${upstream}" | prefix_lock "$dir"
        echo "${dir} ${url} ${lock_branch} ${upstream}" >> "$TMP_LOCKFILE"
    done

    finish_lock "$2"
}

prepare_lock () {
    TMP_LOCKFILE="$(mktemp)"
}

finish_lock () {
if [[ -n "$1" ]]; then
        lockfile="$1"
    else
        lockfile="$DEFAULT_LOCK_FILE"
    fi

    sort "$TMP_LOCKFILE" > $lockfile
    rm "$TMP_LOCKFILE"
}

# run
echo -e "${GREEN}manage.sh: ${NC}${ACTION}"

case $ACTION in 
    update)
        update_all "$1" "$2";;
    lock)
        lock_all "$1" "$2";;
    *)
        echo "no valid action specified";;
esac
