
# Use dump in local docker installation

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

# Neu aufsetzen der persistenten Postgres-Datenbank

(imi-map-2018-09-06.pgdump durch entsprechenden dateinamen des dumps ersetzen)

- container anhalten

    docker-compose down

- alte datenbank löschen:

    rm -rf postgresql/data/

- container starten:

    docker-compose  -f docker-compose.yml -f docker-compose-db.yml up

- dump nach postgresql/dumps kopieren: e.g.

    cp ../../dumps/imi-map-2018-09-06.pgdump postgresql/dumps/

- bash auf postgres container

    docker exec -ti postgresql-dev bash

- dump einspielen:

    psql --set ON_ERROR_STOP=on  -h localhost -U imi_map imimap < /var/lib/postgresql/dumps/imi-map-2018-09-06.pgdump

dann Datenbank auf neuste Version migrieren

    docker exec -ti imimap-dev bash
    rails db:migrate

DATENMIGRATION - s.u. - AUSFÜHREN!

## Datenmigration
(nach aufsetzen der Datenbank mit Dump, s.o.)

    docker exec -ti imimap-dev bash
    rails db:rollback  # RenameAddressFieldsInCompany must be last
    rake imimap:move_address        # create an address object for each company
    rake imimap:update_internships
    rails db:migrate

### create a user with admin role.
    docker exec -ti imimap-dev bash
    rails console
    User.create(email: 'admin@htw-berlin.de', password: 'geheim12', password_confirmation: 'geheim12', role: :admin)

# On Staging/Production Servers

## SKIP: Stop container (braucht man nicht)

    ssh deployer@imi-map-production.f4.htw-berlin.de
    docker-compose down

## SKIP: Delete old database (!!) (wenn Server über travis gestartet)

    sudo rm -rf postgresql/data/

## Copy dump

In two steps as mounted dirs belong root.

### copy

    scp ../../dumps/imi-map-2018-09-06.pgdump deployer@imi-map-production.f4.htw-berlin.de:/home/deployer

### On production box

    sudo mkdir postgresql/dumps
    sudo mv imi-map-2018-09-06.pgdump postgresql/dumps/

## Start container

    easiest and cleanest: rebuild deploy-production from travis

## Import dump

Falls der Server über das Deployment-Script gestartet wurde, wurde eine neue DB angelegt und migriert, daher:

    docker exec -ti imimap bash
    rake db:drop DISABLE_DATABASE_ENVIRONMENT_CHECK=1
    rake db:create

-- wie lokal, container name ohne -dev, anderer database name
    imi_map_production (steht im docker-compose-production file)

    docker exec -ti postgresql bash
    psql --set ON_ERROR_STOP=on  -h localhost -U imi_map imi_map_production < /var/lib/postgresql/data/imi-map-2018-09-06.pgdump

    Dann Migration und Datenmigration wie lokal ausführen.
