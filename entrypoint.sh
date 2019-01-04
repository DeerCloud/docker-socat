#!/bin/sh

if [ ! -z "$LISTEN_PORT" ] && [ ! -z "$FORWARD_HOST" ] && [ ! -z "$FORWARD_PORT" ]; then
  echo -e "\033[32m0.0.0.0:${LISTEN_PORT} <-- udp --> ${FORWARD_HOST}:${FORWARD_PORT}\033[0m"
  socat UDP-LISTEN:$LISTEN_PORT,fork,reuseaddr UDP:$FORWARD_HOST:$FORWARD_PORT &
  echo -e "\033[32m0.0.0.0:${LISTEN_PORT} <-- tcp --> ${FORWARD_HOST}:${FORWARD_PORT}\033[0m"
  socat TCP-LISTEN:$LISTEN_PORT,fork,reuseaddr TCP:$FORWARD_HOST:$FORWARD_PORT
else
  exec "$@"
fi
