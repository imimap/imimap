# dump from docker container

ssh deployer@imi-map-production.f4.htw-berlin.de
docker exec -ti postgresql bash
pg_dump -h localhost -U imi_map  imi_map_production > imi-map.pgdump
mv imi-map.pgdump /var/lib/postgresql/dumps/imi-map-2018-09-14.pgdump


von lokal:

    scp deployer@imi-map-production.f4.htw-berlin.de:/home/deployer/postgresql/dumps/imi-map-2018-09-14.pgdump .

credentials stehen in docker-compose-production.yml
