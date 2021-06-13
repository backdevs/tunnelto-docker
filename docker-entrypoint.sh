#!/bin/bash
set -e

if [ "${1#-}" == "$1" ]; then
	exec "$@"
fi

set -- tunnelto "$@"

if [ -n "${SUBDOMAIN}" ]; then
  set -- "$@" "--subdomain=${SUBDOMAIN}"
fi

exec "$@"