start:
	docker-compose up -d
stop:
	docker-compose down --rmi all -v --remove-orphans
restart:
	docker-compose down --rmi all -v --remove-orphans
	docker-compose up -d
rebuild:
	docker-compose up -d --build --force-recreate imimap
import: $(file)
	docker-compose exec imimap sh -c "rails db:drop ; rails db:create"
	docker-compose exec -i postgresql psql --set ON_ERROR_STOP=on -h localhost -U imi_map imimap -f $(file)
	docker-compose exec imimap rails db:migrate
db_migrate:
	docker-compose exec imimap rails db:migrate
db_seed:
	docker-compose exec imimap rails db:seed
prod_ssh:
	ssh deployer@imi-map-production.f4.htw-berlin.de
prod_dump:
	ssh deployer@imi-map-production.f4.htw-berlin.de "docker exec postgresql pg_dump -h localhost -U imi_map  imi_map_production" > imi-map-$(date +%Y-%m-%d).pgdump
