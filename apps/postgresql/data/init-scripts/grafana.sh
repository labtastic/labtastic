#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
	CREATE USER grafana WITH ENCRYPTED PASSWORD 'grafana';
	CREATE DATABASE grafana;
	GRANT ALL PRIVILEGES ON DATABASE grafana TO grafana;
EOSQL