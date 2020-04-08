#!/bin/bash
set -e

rm -f /portal-solar-dev-test/tmp/pids/server.pid
yarn install --check-files

echo "Criando banco ..."

rake db:create
rake db:migrate

echo "Finalizando criação do banco ..."

exec "$@"