# Create Dump from DB in Docker Container, e.g. Production

## Production

    ci-cd/create-dump.sh

### Einzelne Schritte:

#### Auf Host Dump erzeugen

   ssh deployer@imi-map-production.f4.htw-berlin.de
   docker exec -ti postgresql pg_dump -h localhost -U imi_map  imi_map_production > imi-map-$(date +%Y-%m-%d).pgdump
   exit

#### Dump Kopieren

   scp deployer@imi-map-production.f4.htw-berlin.de:imi-map-$(date +%Y-%m-%d).pgdump .
