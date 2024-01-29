#!/bin/bash

openssl x509 -in "/app/certs/${CERT_COMMON_NAME}.cert" -checkend $(( HEALTHCHECK_DAYS * 86400 )) || exit 1
