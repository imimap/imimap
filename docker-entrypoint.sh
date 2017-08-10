#!/usr/bin/env bash
set -eo pipefail
echo "IMI-Map entrypoint"

# test if postgresql is up
while ! nc -z postgresql 5432; do sleep 1; done

cd /usr/src/app
exec "$@"
