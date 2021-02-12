#!/usr/bin/env sh
# Prepare and run the static analysis process
#
# Copyright 2020 林博仁(Buo-ren, Lin) <Buo.Ren.Lin@gmail.com>
# SPDX-License-Identifier: CC-BY-SA-4.0

set \
    -e \
    -u

# Install pre-commit dependencies
apk add \
    gcc \
    git \
    libffi-dev \
    make \
    musl-dev \
    openssl-dev \
    py3-pip \
    python3 \
    python3-dev

# Install shellcheck hook dependencies
apk add \
    shellcheck

# Install markdownlint hook dependencies
apk add \
	bash \
    nodejs \
    npm

# Install pip
# --ignore-installed: Avoid pip #5247 issue's bug
# https://github.com/pypa/pip/issues/5247
pip3 install \
    --ignore-installed \
    pre-commit

# Run pre-commit for all files in repository
# https://pre-commit.com/
pre-commit run \
    --all-files
