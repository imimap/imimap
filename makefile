start:
	docker-compose up -d
down:
	docker-compose down
stop:
	docker-compose down --rmi all -v --remove-orphans
restart:
	docker-compose down --rmi all -v --remove-orphans
	docker-compose up -d
rebuild:
	docker-compose up -d --build --force-recreate imimap
test:
	docker-compose exec imimap rails db:create RAILS_ENV=test
	docker-compose exec imimap rails db:migrate RAILS_ENV=test
	docker-compose exec imimap rspec
import: $(file)
	docker-compose exec imimap sh -c "rails db:drop ; rails db:create"
	cat $(file) | docker-compose exec -T postgresql psql --set ON_ERROR_STOP=on -h localhost -U imi_map imimap -f -
	docker-compose exec imimap rails db:migrate
db_migrate:
	docker-compose exec imimap rails db:migrate
db_seed:
	docker-compose exec imimap rails db:seed
factory_lint:
	docker-compose exec imimap rails factory_bot:lint
ssh_prod:
	ssh deployer@imi-map.f4.htw-berlin.de
ssh_staging:
	ssh deployer@imi-map-staging.f4.htw-berlin.de
prod_dump:
	mkdir -p dumps
	ssh deployer@imi-map.f4.htw-berlin.de "docker exec postgresql pg_dump -h localhost -U imi_map  imi_map_production" > dumps/imi-map-$(shell date +%Y-%m-%d).pgdump
start_db:
	docker-compose -f docker-compose-db.yml -f docker-compose.yml up -d
start_dump: $(file)
	rm -rf postgres
	docker-compose -f docker-compose-db.yml -f docker-compose.yml up -d
	cat $(file) | docker-compose exec -T postgresql psql --set ON_ERROR_STOP=on -h localhost -U imi_map imimap -f -
	docker-compose exec imimap rails db:migrate
import_dump: $(file)
	docker-compose exec -T imimap rails db:drop
	docker-compose exec -T imimap rails db:create
	cat $(file) | docker-compose exec -T postgresql psql --set ON_ERROR_STOP=on -h localhost -U imi_map imimap -f -
	docker-compose exec imimap rails db:migrate
bash:
	docker-compose exec imimap bash
c:
	docker-compose exec imimap rails c
docker_radical_cleanup:
	docker rmi $(docker images -qa)
