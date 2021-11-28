#!/usr/bin/env bash
# Build gettext translatable messages template
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

if test "${#}" -ne 0; then
    printf \
        'Usage: %s\n' \
        "${0}"
    exit 1
fi

declare -A dependencies=(
    [coreutils]='Coreutils - GNU core utilities <https://www.gnu.org/software/coreutils/>'
    [gettext]='GNU gettext <https://www.gnu.org/software/gettext/>'
    [git]='Git <https://git-scm.com/>'
    [sed]='GNU sed <https://www.gnu.org/software/sed/>'
)
declare -A required_commands=(
    [git]="${dependencies[git]}"
    [mkdir]="${dependencies[coreutils]}"
    [realpath]="${dependencies[coreutils]}"
    [sed]="${dependencies[sed]}"
    [xgettext]="${dependencies[gettext]}"
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
git_describe="$(
    git describe \
        --always \
        --dirty \
        --tags
)"
project_version="${git_describe#v}"
locale_dir="${project_dir}/share/locale"
mkdir \
    --parents \
    --verbose \
    "${locale_dir}"
template="${locale_dir}/woeusb.pot"

pushd "${project_dir}" >/dev/null
xgettext \
    --copyright-holder='WoeUSB contributors <https://github.com/WoeUSB/WoeUSB/graphs/contributors>' \
    --language=Shell \
    --msgid-bugs-address=https://github.com/WoeUSB/WoeUSB/issues \
    --output="${template}" \
    --package-name=woeusb \
    --package-version="${project_version}" \
    ./sbin/woeusb
popd >/dev/null

# False positive: Workaround "reuse._util - ERROR - Could not parse 'GPL-3.0-or-later/' \'" error
sed \
    --in-place \
    --expression 's/SOME DESCRIPTIVE TITLE\./GNU gettext message catalog template for WoeUSB/' \
    --expression "s/Copyright (C) YEAR/Copyright (C) $(date +%Y)/" \
    --expression 's/CHARSET/UTF-8/' \
    --expression 's/This file is distributed under the same license as the woeusb package./SPDX''-License-Identifier: GPL-3.0-or-later/' \
    "${template}"

printf \
    'Info: Template generated at "%s"\n' \
    "${template}"
