#!/usr/bin/env bash
# Build machine-readable message catalogs from their textual counterparts
#
# Copyright © 2021 WoeUSB project contributors
# SPDX-License-Identifier: GPL-3.0-or-later
#
# Reference:
#
# * GNU gettext utilities: msgfmt Invocation
#   https://www.gnu.org/software/gettext/manual/html_node/msgfmt-Invocation.html#msgfmt-Invocation
set \
    -o errexit \
    -o nounset

if test "${#}" -ne 0; then
    printf \
        'Usage: %s\n' \
        "${0}"
    exit 1
fi

declare -A dependencies=(
    [coreutils]='Coreutils - GNU core utilities <https://www.gnu.org/software/coreutils/>'
    [gettext]='GNU gettext <https://www.gnu.org/software/gettext/>'
)
declare -A required_commands=(
    [mkdir]="${dependencies[coreutils]}"
    [msgfmt]="${dependencies[gettext]}"
    [realpath]="${dependencies[coreutils]}"
)
dependency_check_failed=false
for required_command in "${!required_commands[@]}"; do
    if ! command -v "${required_command}" >/dev/null; then
        printf \
            'Error: This program requires the "%s" command to be available in your command search PATHs.\n' \
            "${required_command}" \
            1>&2
        dependency_check_failed=true
    fi
done
if test "${dependency_check_failed}" == true; then
    exit 2
fi

script="$(
    realpath \
        --strip \
        "${BASH_SOURCE[0]}"
)"
script_dir="${script%/*}"
project_dir="$(
    realpath \
        --strip \
        "${script_dir%/*}"
)"
locale_dir="${project_dir}/share/locale"

shopt \
    -s \
    globstar \
    nullglob

pushd "${locale_dir}" >/dev/null
    for po_file in **/*.po; do
        mo_file="${po_file%.po}.mo"
        msgfmt \
            --check \
            --output-file="${mo_file}" \
            --statistics \
            "${po_file}"
    done
popd >/dev/null

printf \
    'Info: Machine-readable message catalogs built successfully\n'
