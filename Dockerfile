FROM alpine:latest

ARG BOOST_VERSION="1.87.0"
ARG BOOST_VARIANT="release"

ENV TZ="UTC" \
    TERM=xterm-256color \
    BOOST_ROOT="/srv/boost"

WORKDIR /srv

COPY scripts/install_dependencies.sh install_dependencies.sh
COPY scripts/install_boost.sh install_boost.sh

RUN sh install_dependencies.sh \
    && sh install_boost.sh