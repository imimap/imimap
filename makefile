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
	cat $(file) | docker-compose exec -T postgresql psql --set ON_ERROR_STOP=on -h localhost -U imi_map imimap -f -
db_migrate:
	docker-compose exec -T imimap rails db:migrate
db_seed:
	docker-compose exec -T imimap rails db:seed

