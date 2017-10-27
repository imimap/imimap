docker-compose -f docker-compose-production.yml up -d
docker-compose -f docker-compose-production.yml exec imimap rake assets:precompile
docker-compose -f docker-compose-production.yml exec imimap ./ci-cd/wait-for-db-connection.sh
docker-compose -f docker-compose-production.yml exec imimap bundle exec rake db:migrate
