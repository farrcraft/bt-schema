Create a db user:

sudo -u postgres bash -c "psql -c \"CREATE USER brewtheory WITH PASSWORD 'brewtheory';\""
bash -c "psql -c \"CREATE USER brewtheory WITH PASSWORD 'brewtheory';\" -d postgres"

psql postgres -c "CREATE DATABASE brewtheory WITH OWNER 'brewtheory' ENCODING 'UTF8' TEMPLATE template0"

psql brewtheory -f schema.sql

SELECT * FROM pg_available_extensions;

# note: extensions are per-db
psql postgres -d brewtheory -c 'CREATE EXTENSION IF NOT EXISTS "uuid-ossp";'

SELECT * FROM pg_extension;

createuser -s postgres