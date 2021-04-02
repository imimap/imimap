# call this before start if you want a mock ldap
set_env:
	export RAILS_MASTER_KEY=asdfasfd
	export LDAP=ALWAYS_RETURN_TRUE
start: # start with db in container
	docker-compose up -d
start_db: # start with locally persisted db
	docker-compose -f docker-compose-db.yml -f docker-compose.yml up -d
down:
	docker-compose down
stop:
	docker-compose down --rmi all -v --remove-orphans
restart:
	docker-compose down --rmi all -v --remove-orphans
	docker-compose up -d
rebuild:
	docker-compose up -d --build --force-recreate imimap
test_db:
	docker-compose exec imimap rails db:create RAILS_ENV=test
	docker-compose exec imimap rails db:migrate RAILS_ENV=test
test:
	docker-compose exec imimap rspec
travis:
	docker-compose exec imimap rails db:create RAILS_ENV=test
	docker-compose exec imimap rails db:migrate RAILS_ENV=test
	docker-compose exec imimap rspec
	docker-compose exec imimap rails factory_bot:lint
	docker-compose exec imimap rails db:seed
# make file=dumps/dump-xs import
import: $(file)
	docker-compose down
	docker-compose -f docker-compose-db.yml -f docker-compose.yml up -d
	docker-compose exec imimap sh -c "rails db:drop ; rails db:create"
	cat $(file) | docker-compose exec -T postgresql psql --set ON_ERROR_STOP=on -h localhost -U imi_map imimap -f -
	docker-compose exec imimap rails db:migrate
plain_import: $(file)
	cat $(file) | docker-compose exec -T postgresql psql --set ON_ERROR_STOP=on -h localhost -U imi_map imimap -f -
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
bash:
	docker-compose exec imimap bash
c:
	docker-compose exec imimap rails c
docker_radical_cleanup:
	docker-compose down
	docker rm $(docker ps -qa)
	docker rmi $(docker images -qa)
# targets to test the production build. set a tag before running them:
# export TAG=sometesttag
# export DEPLOYMENT_TAG=
# export RAILS_MASTER_KEY=this has to be the real master key.
build_prod:
	docker build -f Dockerfile.production --build-arg RAILS_MASTER_KEY=${RAILS_MASTER_KEY}  -t imimap/imimap:${DEPLOYMENT_TAG} .
start_prod: # start with db in container
	docker-compose -f docker-compose-production.yml up -d
start_db_prod: # start with locally persisted db
	docker-compose -f docker-compose-db.yml -f docker-compose-production.yml up -d
down_prod:
	docker-compose -f docker-compose-production.yml down
stop_prod:
	docker-compose -f docker-compose-production.yml down --rmi all -v --remove-orphans
restart_prod:
	docker-compose -f docker-compose-production.yml down --rmi all -v --remove-orphans
	docker-compose -f docker-compose-production.yml up -d
rebuild_prod:
	docker-compose -f docker-compose-production.yml up -d --build --force-recreate imimap
loc_db_test:
	 rails db:drop db:create db:migrate RAILS_ENV=test
