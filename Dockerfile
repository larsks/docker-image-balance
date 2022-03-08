FROM docker.io/alpine:latest AS build
ARG BALANCE_VERSION=3.57

WORKDIR /src
RUN apk add --update curl alpine-sdk
RUN curl -o balance-${BALANCE_VERSION}.tar https://download.inlab.net/Balance/${BALANCE_VERSION}/balance-${BALANCE_VERSION}.tar
RUN tar xf balance-${BALANCE_VERSION}.tar
RUN cd balance-${BALANCE_VERSION} && make

FROM docker.io/alpine:latest
ARG BALANCE_VERSION=3.57
COPY --from=build /src/balance-${BALANCE_VERSION}/balance /usr/local/bin/balance
ENTRYPOINT ["/usr/local/bin/balance", "-f"]
