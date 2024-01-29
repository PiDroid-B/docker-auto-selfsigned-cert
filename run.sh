#!/bin/bash
set -e
set -o pipefail
bash init.sh

/usr/sbin/crond -f -l 8 -c /etc/crontabs/
