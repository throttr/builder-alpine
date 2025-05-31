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
    zlib-static \
    zstd-static \
    libcurl \
    curl-dev \
    protobuf-dev \
    python3 \
    doxygen \
    graphviz \
    rsync \
    gcovr \
    lcov \
    autoconf \
    automake \
    libtool \
    m4

ln -sf /usr/share/zoneinfo/${TZ:-UTC} /etc/localtime
echo "${TZ:-UTC}" > /etc/timezone

git clone https://github.com/libunwind/libunwind.git
cd libunwind
autoreconf -i
./configure --enable-static --disable-shared
make -j$(nproc)
make install
cd ..
rm libunwind -Rf

git clone https://github.com/getsentry/sentry-native.git sentry
cd sentry
git checkout tags/0.8.5
git submodule update --init --recursive
cmake -B build -DCMAKE_BUILD_TYPE=RelWithDebInfo -DBUILD_SHARED_LIBS=OFF -DSENTRY_BACKEND=crashpad
cmake --build build --parallel
cmake --install build --config RelWithDebInfo
cd ..
rm sentry -Rf