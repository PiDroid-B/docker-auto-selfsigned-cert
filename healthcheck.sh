#!/bin/bash

[ -n "$(find /app/ last -mmin -${HEALTHCHECK_MIN} -type f)" ] || exit 1
