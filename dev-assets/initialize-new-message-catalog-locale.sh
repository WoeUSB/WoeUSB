#!/usr/bin/env bash
# Initialize new gettext message catalog for specified locale
#
# Copyright © 2021 WoeUSB project contributors
# SPDX-License-Identifier: GPL-3.0-or-later
#
# Reference:
#
# * GNU gettext utilities: msginit Invocation
#   https://www.gnu.org/software/gettext/manual/html_node/msginit-Invocation.html#msginit-Invocation
set \
    -o errexit \
    -o nounset

if test "${#}" -ne 1; then
    printf \
        'Usage: %s _locale_code_\n' \
        "${0}" \
        1>&2
    exit 1
fi

declare -A dependencies=(
    [coreutils]='Coreutils - GNU core utilities <https://www.gnu.org/software/coreutils/>'
    [gettext]='GNU gettext <https://www.gnu.org/software/gettext/>'
)
declare -A required_commands=(
    [mkdir]="${dependencies[coreutils]}"
    [msginit]="${dependencies[gettext]}"
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

locale_code="${1}"; shift

if [[ ! ${locale_code} =~ [[:alpha:]]{2}_[[:alpha:]]{2}(\..+)? ]]; then
    # false positive: not a command substitution
    # shellcheck disable=SC2016
    printf \
        'Error: Invalid locale code "%s", refer the `--locale` command option of the msginit(1) manual page for the specification.\n' \
        "${locale_code}" \
        1>&2
    exit 3
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

# NOTE: Basic Shell Features » Shell Expansions » '${PARAMETER/PATTERN/STRING}'
if test "${project_dir// }" != "${project_dir}"; then
    printf \
        "Warning: Space character is detected in the project path, which may trigger msginit's bug.  Try to move/mount it to a safe path if you encounter errors.\\n" \
        1>&2
fi

locale_dir="${project_dir}/share/locale"
mkdir \
    --parents \
    --verbose \
    "${locale_dir}"
template="${locale_dir}/woeusb.pot"

if ! test -e "${template}"; then
    printf \
        'Error: Message catalog template file not exist, please generate it by running %s beforehand.\n' \
        "${script_dir}/build-gettext-template.sh" \
        1>&2
    exit 4
fi

locale_messages_dir="${locale_dir}/${locale_code}/LC_MESSAGES"
mkdir \
    --parents \
    --verbose \
    "${locale_messages_dir}"
message_catalog="${locale_messages_dir}/woeusb.po"
msginit \
    --input="${project_dir}/share/locale/woeusb.pot" \
    --locale="${locale_code}" \
    --output="${message_catalog}"

sed \
    --in-place \
    --expression "s/ template/(${locale_code})/" \
    "${message_catalog}"

printf \
    'Info: Initialization successful, message catalog generated at "%s"\n' \
    "${message_catalog}"
