FROM golang:1.19-alpine3.16 AS base

RUN apk --update upgrade && apk --no-cache --update-cache --upgrade --latest add ca-certificates build-base gcc

WORKDIR /build

ADD go.mod go.mod
ADD go.sum go.sum

ENV GO111MODULE on
ENV CGO_ENABLED 1

RUN go mod download

ADD . .

ARG VERSION

RUN go build  \
    -ldflags="-X main.version=${VERSION}" \
    -o /usr/bin/capo

FROM alpine:3.16

RUN addgroup -S capo; \
    adduser -S capo -G capo -D -u 10000 -s /bin/nologin;

COPY --from=base /usr/bin/capo /usr/bin/capo

USER 10000

ENTRYPOINT ["capo"]
CMD ["--auth-config", "/etc/capo/authn.yaml"]
