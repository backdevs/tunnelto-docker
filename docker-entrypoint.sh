#!/bin/bash
set -e

# check if the first argument passed in looks like a flag
if [ "${1#-}" != "$1" ]; then
  set -- tunnelto "$@"
fi

## check if the first argument passed in is tunnelto and if it's the only one
if [ "$#" = 1 ] && [ "$1" = "tunnelto" ]; then
  if [ -n "${DASHBOARD_PORT}" ]; then
    set -- "$@" "--dashboard-port=${DASHBOARD_PORT}"
  fi

  if [ -n "${KEY}" ]; then
    set -- "$@" "--key=${KEY}"
  fi

  if [ -n "${SCHEME}" ]; then
    set -- "$@" "--scheme=${SCHEME}"
  fi

  if [ -n "${HOST}" ]; then
    set -- "$@" "--host=${HOST}"
  fi

  if [ -n "${PORT}" ]; then
    set -- "$@" "--port=${PORT}"
  fi

  if [ -n "${SUBDOMAIN}" ]; then
    set -- "$@" "--subdomain=${SUBDOMAIN}"
  fi
fi

set -- tini -- "$@"

exec "$@"
