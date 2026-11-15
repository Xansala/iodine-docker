FROM alpine:3.22 AS build
ARG IODINE_REF=v0.9.1
RUN apk add --no-cache build-base git linux-headers zlib-dev
RUN git clone --depth 1 --branch "${IODINE_REF}" https://github.com/yarrick/iodine /src
WORKDIR /src
RUN ls -la /src && git log -1 --oneline && find /src -maxdepth 2 -iname 'Makefile*'
RUN make
RUN make install DESTDIR=/out prefix=/usr
