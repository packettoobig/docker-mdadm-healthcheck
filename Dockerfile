FROM alpine

LABEL maintainer="Pilbbq"

ENV HEALTHCHECK_FREQUENCY=60
ENV HEALTHCHECK_URL=
ENV CURL_TIMEOUT=5
ENV CURL_MAXTIME=10

RUN apk update \
    && apk add --no-cache curl \
    && rm -rf /var/cache/apk/*

COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]

CMD [""]
