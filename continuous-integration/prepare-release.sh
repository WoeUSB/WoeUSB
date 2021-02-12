#!/usr/bin/env sh
# Prepare release for upload
#
# Copyright © 2021 林博仁(Buo-ren, Lin) <Buo.Ren.Lin@gmail.com>
# SPDX-License-Identifier: GPL-3.0-or-later

# Ensure script terminates when problems occurred
set \
    -o errexit \
    -o nounset

apk add \
    git \
    sed

script_dir="$(
    realpath "${0%/*}"
)"
product_dir="$(
    realpath \
        "${script_dir}"/..
)"
git_describe="$(
    git describe \
        --always \
        --tags \
        --dirty
)"
product_version="${git_describe#v}"

cp \
    "${product_dir}"/sbin/woeusb \
    "${product_dir}"/distribution/standalone/woeusb-"${product_version}".bash
sed \
    --regexp-extended \
    --in-place \
    "s/@@WOEUSB_VERSION@@/${product_version}/" \
    "${product_dir}"/distribution/standalone/woeusb-"${product_version}".bash
