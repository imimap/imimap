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
echo "+++ pulling and starting docker containers"
docker-compose -f docker-compose-production.yml up -d
exit_on_error $?

echo "+++ Asset precompilation"
docker-compose -f docker-compose-production.yml exec imimap rake assets:precompile
exit_on_error $?

echo "+++ Wait for postgres"
docker-compose -f docker-compose-production.yml exec imimap ./ci-cd/wait-for-db-connection.sh
exit_on_error $?

echo "+++ Database Migration"
docker-compose -f docker-compose-production.yml exec imimap bundle exec rake db:migrate
exit_on_error $?
