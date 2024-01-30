#!/bin/bash

[[ $(find /app/last -mmin -${HEALTHCHECK_MIN} -type f -print | wc -l) -eq 0 ]] && exit 1
