FROM alpine

LABEL maintainer="Pilbbq"

ENV HEALTHCHECK_FREQUENCY=60
ENV HEALTHCHECK_URL=

RUN apk update \
    && apk add --no-cache curl \
    && rm -rf /var/cache/apk/*

COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]

CMD [""]
