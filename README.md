# wmts-db
[![Build Status](https://travis-ci.org/edigonzales/wmts-db.svg?branch=master)](https://travis-ci.org/edigonzales/wmts-db)
[![Docker Pulls](https://img.shields.io/docker/pulls/sogis/wmts-db.svg)](https://hub.docker.com/r/sogis/wmts-db)


Docker image providing a PostGIS database for sogis WMTS.

## Building and testing the image

```
docker build -t sogis/wmts-db:latest .
docker-compose -f docker-compose.test.yml build
docker-compose -f docker-compose.test.yml down
docker-compose -f docker-compose.test.yml run sut
```

## Running the image

Run the command below for running the image. The meaning of the environment variables used is as follows:

- `PG_DATABASE`: The name of the database to create
- `PG_LOCALE`: Locale for the database to create
- `PG_PRIMARY_PORT`: The port PostgreSQL is running on
- `PG_MODE`: If set to primary, PostgreSQL runs as primary instance (as opposed to a standby or replica instance)
- `PG_USER`: This is the database user that owns all database objects in the PG_DATABASE database (except system objects); this user is granted all privileges on the PG_DATABASE database
- `PG_PRIMARY_USER`: The database user that replicates data to a possible standby DB instance (not used currently, but this environment variable is mandatory)
- `PG_ROOT_PASSWORD`: The password of the postgres database user (the built-in database superuser)
- `PG_WRITE_USER`: The database user that has write (and read) privileges for all tables in the database (except system tables); use this user for importing data into the database
- `PG_READ_USER`: The database user that has read privileges for all database tables; use this user for querying data

```
docker run --rm --name wmts-db -p 54321:5432 --hostname primary \
-e PG_DATABASE=wmts -e PG_LOCALE=de_CH.UTF-8 -e PG_PRIMARY_PORT=5432 -e PG_MODE=primary \
-e PG_USER=admin -e PG_PASSWORD=admin \
-e PG_PRIMARY_USER=repl -e PG_PRIMARY_PASSWORD=repl \
-e PG_ROOT_PASSWORD=secret \
-e PG_WRITE_USER=gretl -e PG_WRITE_PASSWORD=gretl \
-e PG_READ_USER=ogc_server -e PG_READ_PASSWORD=ogc_server \
-v /tmp:/pgdata \
sogis/wmts-db:latest
```

This places the PostgreSQL data under /tmp/primary. If you want to keep the data longer than just until you log out, run instead e.g.:
```
mkdir -m 0777 ~/pgdata-wmts
docker run --rm --name wmts-db -p 54321:5432 --hostname primary \
-e PG_DATABASE=wmts -e PG_LOCALE=de_CH.UTF-8 -e PG_PRIMARY_PORT=5432 -e PG_MODE=primary \
-e PG_USER=admin -e PG_PASSWORD=admin \
-e PG_PRIMARY_USER=repl -e PG_PRIMARY_PASSWORD=repl \
-e PG_ROOT_PASSWORD=secret \
-e PG_WRITE_USER=gretl -e PG_WRITE_PASSWORD=gretl \
-e PG_READ_USER=ogc_server -e PG_READ_PASSWORD=ogc_server \
-v ~/pgdata-wmts:/pgdata:delegated \
sogis/wmts-db:latest
```

## Logging into the container

```
docker exec -it wmts-db /bin/bash
```

## Connecting to the database (example for querying data)

```
psql -h localhost -p 54321 -d wmts -U ogc_server
```

## Creating or updating the SQL scripts that populate the database

Run `ILI2PG_PATH=/Users/stefan/apps/ili2pg-4.3.2/ili2pg-4.3.2.jar ./create_schema_sql_scripts.sh` for generating the SQL script that creates the DB schemas and tables. (Set `ILI2PG_PATH` according to your installation.) After updating the SQL script, remember to commit the changes to the repository.

## Commands for importing data manually (example)

```
curl -O https://geoweb.so.ch/av_datenabgabe/av_daten/itf_so/254900.zip
unzip 254900.zip 254900/254900.itf
ILI2PG_PATH=/Users/stefan/apps/ili2pg-4.3.2/ili2pg-4.3.2.jar && java -jar $ILI2PG_PATH \
--dbhost localhost --dbport 54321 --dbdatabase oereb --dbusr gretl --dbpwd gretl \
--dbschema agi_dm01avso24 --models DM01AVSO24LV95 \
--dataset 2549 --import 254900/254900.itf
```
