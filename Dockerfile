FROM alpine:latest

ENV CRON="30 2 * */3 *"
ENV CERT_DAYS=365
ENV CERT_COUNTRY_NAME="US"
ENV CERT_STATE_NAME="Sky"
ENV CERT_LOCALITY_NAME="Sun"
ENV CERT_ORGANIZATION_NAME="My Home"
ENV CERT_ORGANIZATION_UNIT="reverse proxy"
ENV CERT_COMMON_NAME=""
# 2 days
ENV HEALTHCHECK_MIN=2880

RUN apk update && \
    apk upgrade --available && \
    apk add --no-cache bash && \
    apk add --no-cache logrotate && \
    apk add --no-cache openssl

ADD . /app/
WORKDIR /app

VOLUME /app/certs
VOLUME /app/hook

HEALTHCHECK --interval=10m --timeout=30s --retries=1 CMD bash healthcheck.sh || exit 1

CMD [ "bash", "run.sh" ]
