#!/bin/bash
echo "+++ start $0"

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

echo "+++ copying docker-compose file to $DEPLOYMENT_HOST"
scp -i id_rsa_$DEPLOYMENT_ENVIRONMENT -o StrictHostKeyChecking=no docker-compose-production.yml $DEPLOMENT_USER@$DEPLOYMENT_HOST:~
exit_on_error $?
echo "+++ copying deployment-steps-on-production-machine.sh to server"
scp -i id_rsa_$DEPLOYMENT_ENVIRONMENT -o StrictHostKeyChecking=no ci-cd/deployment-steps-on-production-machine.sh $DEPLOMENT_USER@$DEPLOYMENT_HOST:~
exit_on_error $?

echo "+++ sshing to $DEPLOYMENT_HOST and calling deployment-steps-on-production-machine.sh"
# ssh  -i id_rsa_$DEPLOYMENT_ENVIRONMENT -o StrictHostKeyChecking=no $DEPLOMENT_USER@$DEPLOYMENT_HOST "export set TAG=$DEPLOYMENT_TAG; export set SECRET_KEY_BASE=$SECRET_KEY_BASE; echo "TAG: $TAG"; docker-compose -f docker-compose-production.yml up -d; docker-compose -f docker-compose-production.yml exec imimap ./ci-cd/wait-for-db-connection.sh ; docker-compose -f docker-compose-production.yml exec imimap bundle exec rake db:migrate"
# and yes, these variables are meant to expand on the client side.
if [ -z ${RAILS_MASTER_KEY} ]; then echo RAILS_MASTER_KEY missing ; else echo RAILS_MASTER_KEY exists; fi
if [ -z ${LDAP} ]; then echo LDAP missing ; else echo LDAP exists; fi

ssh  -i id_rsa_$DEPLOYMENT_ENVIRONMENT -o StrictHostKeyChecking=no $DEPLOMENT_USER@$DEPLOYMENT_HOST "export set TAG=$DEPLOYMENT_TAG; export set LDAP=${LDAP}; export set RAILS_MASTER_KEY=$RAILS_MASTER_KEY; . ./deployment-steps-on-production-machine.sh"
exit_on_error $?

echo "+++ copying crontab file file to $DEPLOYMENT_HOST"
scp -i id_rsa_$DEPLOYMENT_ENVIRONMENT -o StrictHostKeyChecking=no ci-cd/crontab $DEPLOMENT_USER@$DEPLOYMENT_HOST:~
echo "+++ sshing to $DEPLOYMENT_HOST and create the crontab"
ssh  -i id_rsa_$DEPLOYMENT_ENVIRONMENT -o StrictHostKeyChecking=no $DEPLOMENT_USER@$DEPLOYMENT_HOST "cat crontab | crontab - ; rm crontab"


echo "+++ Deployment successful"
echo "+++ end $0"
