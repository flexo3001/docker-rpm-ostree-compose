#!/bin/sh

set -eu

./compose.sh || { echo 'rpm-ostree compose failed' ; exit 1; }

if [ "$(id -u)" = '0' ]; then
  chown -R "ostree-serve:ostree-serve" /var/tmp/repo && exec sudo -u ostree-serve "$@"
else
  exec "$@"
fi
