#!/bin/bash
#set -x

[[ "XX" == "X${CERT_COMMON_NAME}X" ]] && echo "Need your domain in env CERT_COMMON_NAME > exit (1)" && exit 1


echo "${CRON} bash /app/renew.sh" | crontab -

chmod 0644 /etc/crontabs/renew

for d in /app/hook/on_init/ /app/hook/on_renew_start/ /app/hook/on_renew_end/ ; do
	[[ -d "$d" ]] || mkdir -p "$d"
done

mv /app/logrotate.d/renew.conf /etc/logrotate.d/renew.conf

echo "initialized..."

if [[ $(ls -A /app/hook/on_init/ ) ]] ; then
  echo "### /app/hook/on_init/ # hook(s) detected # start loop ###"
  for f in $( find /app/hook/on_init/ -type f | sort -g ); do
    bash "${f}"
  done
  echo "### /app/hook/on_init/ # end loop ###"
fi

echo "ready !"

bash /app/renew.sh
