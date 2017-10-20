
To import a dump within a docker postgres container, the directory containing
the database must be mounted to an outside directory. (otherwise, the db will
be recreated when the container restarts)


thus, use docker-compose-db.yml :

    docker-compose -f docker-compose-db.yml up

this contains the following mappings:

- ./postgresql/data:/var/lib/postgresql/data
- ./postgresql/dumps:/var/lib/postgresql/dumps

copy the dump to

    ./postgresql/dumps

enter the postgres container and import the dump:

    docker exec -ti postgresql-dev bash
    psql --set ON_ERROR_STOP=on  -h localhost -U imi_map imimap < /var/lib/postgresql/dumps/imi-map.pgdump
