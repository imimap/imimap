#!/bin/bash
exit_on_error () {
  sshexit=$1
  if [ $sshexit -eq 0 ]; then
    echo "step ok"
  else
      echo "ERROR: step failed with exit code $sshexit"
      echo "ERROR: deployment failed"
      exit $sshexit
  fi
}
warn_on_error () {
  sshexit=$1
  if [ $sshexit -eq 0 ]; then
    echo "step ok"
  else
      echo "WARN: step failed with exit code $sshexit"
      echo "WARN: continuing deployment"
  fi
}
echo "+++++ starting deployment on machine for TAG:[${TAG}]"
if [ -z ${RAILS_MASTER_KEY} ]; then echo RAILS_MASTER_KEY missing ; else echo RAILS_MASTER_KEY exists; fi
if [ -z ${LDAP} ]; then echo LDAP missing ; else echo LDAP exists; fi

dump_file=dumps/imi-map-$(date +%Y-%m-%d)-${TAG}.pgdump
echo "+++++ creating database dump in ${dump_file}"
mkdir -p dumps
docker exec postgresql pg_dump -h localhost -U imi_map  imi_map_production > $dump_file
warn_on_error $?
echo "+++++ stopping docker containers"
docker-compose -f docker-compose-production.yml down
echo "+++++ pulling and starting docker containers"
docker-compose -f docker-compose-production.yml up -d
exit_on_error $?

echo "+++++ Clean assets "
rm -rf nginx-assets
mkdir -p nginx-assets
echo "+++++ copy assets from container to dir on host"
docker cp imimap:/usr/src/app/public/assets nginx-assets
exit_on_error $?

# echo "+++++ Asset precompilation "
# docker-compose -f docker-compose-production.yml exec imimap rake assets:precompile
# exit_on_error $?

# echo "+++++ instead copy the precompiled assets to new dir"
#       - ./rails/public:/usr/src/app/nginx-assets
# rm -rf ./rails/public # clear out assets directory from host,
# then copy assets to mounted dir to make them accessible from outside the container.
# docker-compose -f docker-compose-production.yml exec imimap cp -r ./public/assets ./nginx-assets
# exit_on_error $?

echo "+++++ Wait for postgres"
docker-compose -f docker-compose-production.yml exec imimap ./ci-cd/wait-for-db-connection.sh
exit_on_error $?

echo "+++++ Database Migration"
echo "+++++ Database Migration"
docker-compose -f docker-compose-production.yml exec imimap bundle exec rails db:migrate
exit_on_error $?
echo "+++++ done with deployment steps on production machene for TAG:[${TAG}]"
