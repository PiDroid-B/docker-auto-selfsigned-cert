# docker-auto-selfsigned-cert

## What?

Sometimes, we just need a self-signed certificate renewer...

## How?

Based on official Alpine image for a smallest size.
It takes our domain and several other information to create ssl self-signed certificate with openssl

## Environment variables

| Environment variable | Default | Possible values | Description |
| --- | --- | --- | --- |
| `CRON` | `30 2 * */3 *` | cron expression | regeneration period |
| `CERT_DAYS` | `365` | specifies the number of days to make a certificate valid for | cetificate lifetimes |
| `CERT_COUNTRY_NAME` | `US` | https://www.ssl.com/country-codes/ | The two-letter country code |
| `CERT_STATE_NAME` | `Sky` | | free string |
| `CERT_LOCALITY_NAME` | `Sun` | | free string |
| `CERT_ORGANIZATION_NAME` | `My Home` | | free string |
| `CERT_ORGANIZATION_UNIT` | `reverse proxy` | | free string |
| `CERT_COMMON_NAME` | `` | your internal domain | MANDATORY certificate is based on your "root" domain |
| `HEALTHCHECK_DAYS` | `100` | number of days | become unhealthly when certificate validation expire after them |

