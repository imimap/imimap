#!/bin/bash
# set by travis - repository settings
export DEPLOY_FROM_BRANCH=master
export DEPLOYMENT_PIPELINE=HTW

# set by travis
export TRAVIS_BRANCH=master
export TRAVIS_TAG=
export TRAVIS_COMMIT=31ee77683bc23a80fcc16c65c35cf0af4f294eeb
export TRAVIS_PULL_REQUEST=false # number or false
export TRAVIS=true

# set by travis.yml
export IMIMAPS_ENVIRONMENT=docker

# set as an parameter to or directly in the script
# export DEPLOYMENT_ENVIRONMENT=production
export DEPLOYMENT_ENVIRONMENT=staging


export DEPLOMENT_USER=deployer
export DEPLOYMENT_HOST=imi-map-staging.f4.htw-berlin.de

export DEPLOYMENT_TAG=$(git log --pretty=format:'%h' -n 1)
echo $DEPLOYMENT_TAG


export DEPLOYMENT_TAG=48a87ae
export DEPLOYMENT_TAG=31ee776


# for using: -remove the -i part
# ssh  -i id_rsa_$DEPLOYMENT_ENVIRONMENT -o StrictHostKeyChecking=no $DEPLOMENT_USER@$DEPLOYMENT_HOST "export set TAG=$DEPLOYMENT_TAG; export set LDAP=${LDAP}; export set RAILS_MASTER_KEY=$RAILS_MASTER_KEY; export set GOOGLE_API_KEY=$GOOGLE_API_KEY; . ./deployment-steps-on-production-machine.sh" 2>&1
# ssh   -o StrictHostKeyChecking=no $DEPLOMENT_USER@$DEPLOYMENT_HOST "export set TAG=$DEPLOYMENT_TAG; export set LDAP=${LDAP}; export set RAILS_MASTER_KEY=$RAILS_MASTER_KEY; export set GOOGLE_API_KEY=$GOOGLE_API_KEY; . ./deployment-steps-on-production-machine.sh" 2>&1
