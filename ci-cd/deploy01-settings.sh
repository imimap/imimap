

# this should be the only file in the deployment process handling environment variables.
echo "checking environment"
echo "TRAVIS_TAG [${TRAVIS_TAG}]"
echo "TRAVIS_BRANCH [${TRAVIS_BRANCH}]"
echo "TRAVIS_COMMIT [${TRAVIS_COMMIT}]"
echo "TRAVIS [${TRAVIS}]"


if [ "$IMIMAPS_ENVIRONMENT" != "docker" ]; then
  echo "DEPLOYMENT: IMIMAPS_ENVIRONMENT is set to ${IMIMAPS_ENVIRONMENT}, skipping deployment"
    export DEPLOYMENT_SHOULD_RUN=false
else

if [ -z "$DEPLOYMENT_PIPELINE" ]; then
    echo "DEPLOYMENT: no DEPLOYMENT_PIPELINE set, skipping deployment"
    export DEPLOYMENT_SHOULD_RUN=false
else

#if [ $false ]; then
if [ "$DEPLOYMENT_ENVIRONMENT" == "staging" ] && [ "$TRAVIS_BRANCH" != "master" ]; then

  echo "DEPLOYMENT: staging will only deploy on master branch"
  export DEPLOYMENT_SHOULD_RUN=false
else

#if [ $false ]; then
if [ "$DEPLOYMENT_ENVIRONMENT" == "production" ] && [ "$TRAVIS_BRANCH" != "$TRAVIS_TAG" ]; then
    echo "DEPLOYMENT: production will only deploy from tag"
    echo "DEPLOYMENT: got TRAVIS_BRANCH [$TRAVIS_BRANCH] and TRAVIS_TAG [$TRAVIS_TAG]"
    export DEPLOYMENT_SHOULD_RUN=false
else

echo "*********************** SWITCHED OFF DEPLOYMENT IN MASTER TO NOT INTERFER WITH TESTING FROM BRANCH htw-staging-server ***************************"
export DEPLOYMENT_SHOULD_RUN=false


echo "TRAVIS_TAG $TRAVIS_TAG"
if [ -z "$TRAVIS_TAG" ]; then
  export DEPLOYMENT_TAG=$TRAVIS_COMMIT
else
  export DEPLOYMENT_TAG=$TRAVIS_TAG
fi

export DEPLOYMENT_DOCKER_ORGANISATION=imimapshtw

echo "all environment checks passed:"
echo "DEPLOYMENT_ENVIRONMENT: $DEPLOYMENT_ENVIRONMENT"
echo "DEPLOYMENT_TAG: $DEPLOYMENT_TAG"
echo "DEPLOYMENT_DOCKER_ORGANISATION: $DEPLOYMENT_DOCKER_ORGANISATION"
echo "DEPLOYMENT_SHOULD_RUN: $DEPLOYMENT_SHOULD_RUN"

fi
fi
fi
fi
