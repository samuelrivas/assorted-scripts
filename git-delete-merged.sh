#!/usr/bin/env bash

## Standard prelude
##====================================================================
set -e
set -u

readonly ARGS=("$@")
readonly NARGS="$#"
readonly PROGNAME="$(basename "$0")"

## Functions
##====================================================================
usage() {
    echo "Usage ${PROGNAME} <branch>" >&2
}

usage_and_exit() {
    usage
    exit 1
}

get_merged() {
    local ref="$1"
    git branch --remotes --merged "$ref" \
        | grep -v "$ref"                 \
        | grep -v "master"
}

delete() {
    local long_name="$1"
    local remote="$(echo "$long_name" | cut -d/ -f1)"
    local branch="$(echo "$long_name" | cut -d/ -f2)"
    local sha="$(git rev-parse "$long_name")"

    echo "Deleting $sha ($long_name)"
    git push $remote :$branch
}

## Main
##====================================================================
main() {
    (( $NARGS == 0 )) && usage_and_exit
    local reference="${ARGS[0]}"
    local merged=("$(get_merged "$reference")")
    local branch

    for branch in ${merged[@]}; do
        delete "$branch"
    done
}

main
