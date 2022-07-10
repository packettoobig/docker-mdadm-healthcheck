FROM alpine

LABEL maintainer="Pilbbq"

ENV HEALTHCHECK_FREQUENCY=300
ENV HEALTHCHECK_URL=
ENV CURL_TIMEOUT=5
ENV CURL_MAXTIME=10

RUN apk update \
    && apk add --no-cache curl grep \
    && rm -rf /var/cache/apk/*

COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]

CMD [""]
