docker exec -ti postgresql "pg_dump -h localhost -U imi_map  imi_map_production > imi-map-$(date +%Y-%m-%d).pgdump"
