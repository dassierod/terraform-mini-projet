#!/bin/bash
set -eu

export DEBIAN_FRONTEND=noninteractive

for attempt in {1..24}; do
  if apt-get -o Acquire::http::Timeout=10 update &&
     apt-get -o Acquire::http::Timeout=10 install -y nginx; then
    systemctl enable --now nginx
    systemctl is-active --quiet nginx
    exit 0
  fi

  sleep 10
done

echo "Impossible d’installer Nginx après 24 tentatives." >&2
exit 1