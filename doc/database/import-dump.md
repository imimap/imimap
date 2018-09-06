
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

enter the postgres container and import the dump:

    docker exec -ti postgresql-dev bash
    psql --set ON_ERROR_STOP=on  -h localhost -U imi_map imimap < /var/lib/postgresql/dumps/imi-map.pgdump


cp ../../dumps/imi-map-2018-08-27.pgdump postgresql/dumps/
psql --set ON_ERROR_STOP=on  -h localhost -U imi_map imimap < /var/lib/postgresql/dumps/imi-maps-2018-08-27.pgdump

DON'T FORGET TO MIGRATE!
rails db:migrate

# Neu aufsetzen der persistenten Postgres-Datenbank

(imi-map-2018-09-06.pgdump durch entsprechenden dateinamen des dumps ersetzen)

- container anhalten
- alte datenbank löschen:
   rm -rf postgresql/data/
- container starten:
    docker-compose  -f docker-compose.yml -f docker-compose-db.yml up
- dump nach postgresql/dumps kopieren: e.g.
   cp ../../dumps/imi-map-2018-09-06.pgdump postgresql/dumps/
- bash auf postgres container
    docker exec -ti postgresql-dev bash
- dump einspielen
    psql --set ON_ERROR_STOP=on  -h localhost -U imi_map imimap < /var/lib/postgresql/dumps/imi-map-2018-09-06.pgdump

dann Datenbank auf neuste Version migrieren
   docker exec -ti imimap-dev bash
   rails db:migrate

DATENMIGRATION - s.u. - AUSFÜHREN!

## Datenbankmigration
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


On Staging/Production Servers
==================================


export TAG=
export RAILS_MASTER_KEY=
docker-compose -f docker-compose-production.yml up



docker-compose exec  imimap bash
rails db:setup DISABLE_DATABASE_ENVIRONMENT_CHECK=1
