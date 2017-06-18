echo "start $0"

echo "DEPLOYMENT_ENVIRONMENT: $DEPLOYMENT_ENVIRONMENT"
echo "DEPLOYMENT_TAG: $DEPLOYMENT_TAG"
echo "Deploying image for environment: $DEPLOYMENT_ENVIRONMENT with tag $DEPLOYMENT_TAG"


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
export set DEPLOMENT_USER=deployer
if [ $DEPLOYMENT_ENVIRONMENT == "staging" ]; then
  export DEPLOYMENT_HOST="imi-map-staging.f4.htw-berlin.de"
fi
if [ $DEPLOYMENT_ENVIRONMENT == "production" ]; then
  export DEPLOYMENT_HOST="imi-map-production.f4.htw-berlin.de"
fi

echo "copying docker-compose file to $DEPLOYMENT_HOST"
scp -i id_rsa_$DEPLOYMENT_ENVIRONMENT -o StrictHostKeyChecking=no docker-compose.yml $DEPLOMENT_USER@$DEPLOYMENT_HOST:~
exit_on_error $?
echo "sshing to $DEPLOYMENT_HOST and calling docker-compose"
ssh  -i id_rsa_$DEPLOYMENT_ENVIRONMENT -o StrictHostKeyChecking=no $DEPLOMENT_USER@$DEPLOYMENT_HOST "export TAG=$DEPLOYMENT_TAG; export SECRET_KEY_BASE=$SECRET_KEY_BASE; echo "TAG: $TAG"; docker-compose up -d ; docker-compose exec imimap bundle exec rake db:migrate"
exit_on_error $?

echo "Deployment successful"
echo "end $0"
