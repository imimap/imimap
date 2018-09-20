
# Use dump in local docker installation

## Preparation
To import a dump within a docker postgres container, the directory containing
the database must be mounted to an outside directory. (otherwise, the db will
be recreated when the container restarts)

thus, use docker-compose-db.yml :

    docker-compose  -f docker-compose.yml -f docker-compose-db.yml up

this contains the following mappings:

- ./postgresql/data:/var/lib/postgresql/data
- ./postgresql/dumps:/var/lib/postgresql/dumps

copy the dump to

    ./postgresql/dumps

## Import

Parallel in beide Container gehen.
1) imimap-dev: database droppen, createn
2) postresql-dev: database importieren

### 1.Clean old database

docker exec -ti imimap-dev bash
rails db:drop
rails db:create

### 2. Import Dump

    docker exec -ti postgresql-dev bash
    psql --set ON_ERROR_STOP=on  -h localhost -U imi_map imimap < /var/lib/postgresql/dumps/imi-map-$(date +%Y-%m-%d).pgdump

(or the appropriate file name of the dump)
