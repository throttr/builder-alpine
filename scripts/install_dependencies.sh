#!/bin/sh
set -e
set -o pipefail

apk update

apk add --no-cache \
    alpine-sdk \
    cmake \
    git \
    wget \
    curl \
    bash \
    zip \
    unzip \
    tzdata \
    libtool \
    automake \
    m4 \
    re2c \
    supervisor \
    openssl-dev \
    zlib-dev \
    libcurl \
    curl-dev \
    protobuf-dev \
    python3 \
    doxygen \
    graphviz \
    rsync \
    gcovr \
    lcov

ln -sf /usr/share/zoneinfo/${TZ:-UTC} /etc/localtime
echo "${TZ:-UTC}" > /etc/timezone