FROM alpine:3.22 AS build
ARG IODINE_REF=v0.9.1
RUN apk add --no-cache build-base git zlib-dev zlib-static
RUN git clone --depth 1 --branch "${IODINE_REF}" https://github.com/yarrick/iodine /src
WORKDIR /src
RUN make && make install prefix=/out

FROM alpine:3.22
RUN apk add --no-cache zlib iptables
COPY --from=build /out/ /usr/
EXPOSE 53/udp
ENTRYPOINT ["iodined"]
