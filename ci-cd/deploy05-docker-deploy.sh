echo "start $0"

echo "DEPLOYMENT_ENVIRONMENT: $DEPLOYMENT_ENVIRONMENT"
echo "DEPLOYMENT_TAG: $DEPLOYMENT_TAG"
echo "Deploying image for environment: $DEPLOYMENT_ENVIRONMENT with tag $DEPLOYMENT_TAG"


export set DEPLOMENT_USER=deployer
if [ $DEPLOYMENT_ENVIRONMENT == "staging" ]; then
  export DEPLOYMENT_HOST="imi-map-staging.f4.htw-berlin.de"
fi
if [ $DEPLOYMENT_ENVIRONMENT == "production" ]; then
  export DEPLOYMENT_HOST="imi-map-production.f4.htw-berlin.de"
fi
echo "in dir"
pwd
echo "copying docker-compose file to $DEPLOYMENT_HOST"
scp -i id_rsa_$DEPLOYMENT_ENVIRONMENT -o StrictHostKeyChecking=no .docker/$DEPLOYMENT_ENVIRONMENT/docker-compose-$DEPLOYMENT_ENVIRONMENT.yml $DEPLOMENT_USER@$DEPLOYMENT_HOST:~
echo "sshing to $DEPLOYMENT_HOST and calling docker-compose"
ssh  -i id_rsa_$DEPLOYMENT_ENVIRONMENT -o StrictHostKeyChecking=no $DEPLOMENT_USER@$DEPLOYMENT_HOST "export TAG=$DEPLOYMENT_TAG; echo "TAG: $TAG"; docker-compose -f ~/docker-compose-$DEPLOYMENT_ENVIRONMENT.yml up -d "

echo "end $0"
