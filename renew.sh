#!/bin/bash

echo "start renew ..."
set -e

openssl x509 -in "/app/certs/${CERT_COMMON_NAME}.crt" -checkend $(( HEALTHCHECK_DAYS * 86400 )) && export VALID_CERTS=1 || export VALID_CERTS=0

if [[ $(ls -A /app/hook/on_renew_start/ ) ]] ; then
  echo "### /app/hook/on_renew_start/ # hook(s) detected # start loop ###"
  for f in $( find /app/hook/on_renew_start/ -type f | sort -g ); do
    bash "${f}"
  done
  echo "### /app/hook/on_renew_start/ # end loop ###"
fi

if [[ VALID_CERTS -eq 1 ]]; then
  echo "Skip (certificates are valid)"
else
  echo "openssl key gen ..."
  SUBJ="/C=${CERT_COUNTRY_NAME}/ST=${CERT_STATE_NAME}/L=${CERT_LOCALITY_NAME}/O=${CERT_ORGANIZATION_NAME}/OU=${CERT_ORGANIZATION_UNIT}/CN=${CERT_COMMON_NAME}"
  echo ">>> ${SUBJ}"
  openssl req \
        -new \
        -newkey rsa:4096 \
        -days ${CERT_DAYS} \
        -nodes \
        -x509 \
        -subj "${SUBJ}" \
        -keyout "/app/certs/${CERT_COMMON_NAME}.key" \
        -out "/app/certs/${CERT_COMMON_NAME}.crt"
fi

if [[ $(ls -A /app/hook/on_renew_end/ ) ]] ; then
  echo "### /app/hook/on_renew_end/ # hook(s) detected # start loop ###"
  for f in $( find /app/hook/on_renew_end/ -type f | sort -g ); do
    bash "${f}"
  done
  echo "### /app/hook/on_renew_end/ # end loop ###"
fi

touch /app/last
