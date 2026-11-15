FROM alpine:3.22 AS build
ARG IODINE_REF=v0.9.1
RUN apk add --no-cache build-base git linux-headers zlib-dev meson ninja pkgconf
RUN git clone --depth 1 --branch "${IODINE_REF}" https://github.com/yarrick/iodine /src
WORKDIR /src
RUN meson setup build --prefix=/usr --buildtype=release
RUN meson compile -C build
RUN DESTDIR=/out meson install -C build

FROM alpine:3.22
RUN apk add --no-cache zlib iptables
COPY --from=build /out/ /
EXPOSE 53/udp
ENTRYPOINT ["iodined"]
