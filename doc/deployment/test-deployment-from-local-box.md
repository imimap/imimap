
Test travis deployment script from local machine
======================================================

prerequisites: you need valid values for these variables:

export DOCKER_USERNAME=[secure]
export DOCKER_PASSWORD=[secure]
export SECRET_KEY_BASE=[secure]

chose the tag you want to deploy:

export TAG=dea5878
export DEPLOYMENT_TAG=dea5878
export DEPLOYMENT_ENVIRONMENT=production


set the other variables:

export set SECRET_KEY_BASE=baa7a08e6afa122478c888c601024948aaf6bf9685f43c50d2e9649692eee25ed4b326e216a42439f36a581c242b8c3c538c71671771fdbf525474911d94ce02
export DEPLOY_FROM_BRANCH=deployment-10
export IMIMAPS_ENVIRONMENT=docker
export DEPLOYMENT_PIPELINE=HTW

then run:

./ci-cd/deploy05-docker-deploy.sh staging
