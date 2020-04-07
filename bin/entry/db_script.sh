#!/bin/bash
set -e

echo "Criando banco ..."

rake db:create
rake db:migrate

echo "Finalizando criação do banco ..."

exec "$@"