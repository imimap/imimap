

# this should be the only file in the deployment process handling environment variables.
echo "checking environment"
echo "TRAVIS_TAG [${TRAVIS_TAG}]"
echo "TRAVIS_BRANCH [${TRAVIS_BRANCH}]"
echo "TRAVIS_COMMIT [${TRAVIS_COMMIT}]"
echo "TRAVIS [${TRAVIS}]"
echo "DEPLOY_FROM_BRANCH [${DEPLOY_FROM_BRANCH}]"
echo "TRAVIS_PULL_REQUEST" [${TRAVIS_PULL_REQUEST}]"

# if, for example for testing purposes, deployments should be triggered
# from another branch than master, set the environment variable
# DEPLOY_FROM_BRANCH within the travis projects settings
# https://travis-ci.org/imimaps/imimaps/settings

echo ""
echo "starting to check wether deployment should run"
export set DEPLOYMENT_SHOULD_RUN=true

# DEPLOY_FROM_BRANCH should be set in a travis setting
if [ -z "$DEPLOY_FROM_BRANCH" ]; then
  export set DEPLOY_FROM_BRANCH=master
fi

if [ -z "$DEPLOYMENT_ENVIRONMENT" ]; then
  echo "DEPLOYMENT_ENVIRONMENT not set, no deployment"
  export set DEPLOYMENT_SHOULD_RUN=false
else

if [ "$IMIMAPS_ENVIRONMENT" != "docker" ]; then
  echo "DEPLOYMENT: IMIMAPS_ENVIRONMENT is set to ${IMIMAPS_ENVIRONMENT}, skipping deployment"
    export set DEPLOYMENT_SHOULD_RUN=false
else

if [ -z "$DEPLOYMENT_PIPELINE" ]; then
    echo "DEPLOYMENT: no DEPLOYMENT_PIPELINE set, skipping deployment"
    export set DEPLOYMENT_SHOULD_RUN=false
else

if [ "$TRAVIS_PULL_REQUEST" != "false" ]; then
  echo "BUILDING PULL REQUEST ${TRAVIS_PULL_REQUEST}, skipping deployment"
    export set DEPLOYMENT_SHOULD_RUN=false
else

if [ "$DEPLOYMENT_ENVIRONMENT" == "staging" ] && [ "$TRAVIS_BRANCH" != "$DEPLOY_FROM_BRANCH" ]; then
  echo "DEPLOYMENT: staging will only deploy on master branch"
  export set DEPLOYMENT_SHOULD_RUN=false
else

#if [ "$DEPLOYMENT_ENVIRONMENT" == "production" ] && [ "$TRAVIS_BRANCH" != "$TRAVIS_TAG" ]; then
# TBD docker-deploy: change this back to above line
if [ "$DEPLOYMENT_ENVIRONMENT" == "production" ] && [ "$TRAVIS_BRANCH" != "$DEPLOY_FROM_BRANCH" ]; then
    echo "DEPLOYMENT deploys for every build to set up deployment" # TBD docker-deploy switch with this line:
    #echo "DEPLOYMENT: production will only deploy from tag"
    echo "DEPLOYMENT: got TRAVIS_BRANCH [$TRAVIS_BRANCH] and TRAVIS_TAG [$TRAVIS_TAG]"
    export set DEPLOYMENT_SHOULD_RUN=false
else

echo "TRAVIS_TAG $TRAVIS_TAG"
if [ -z "$TRAVIS_TAG" ]; then
  export set DEPLOYMENT_TAG=$(echo $TRAVIS_COMMIT | head -c 7)
else
  export set DEPLOYMENT_TAG=$TRAVIS_TAG
fi

export DEPLOYMENT_DOCKER_ORGANISATION=imimap


echo "all environment checks passed:"
echo "DEPLOYMENT_ENVIRONMENT: $DEPLOYMENT_ENVIRONMENT"
echo "DEPLOYMENT_TAG: $DEPLOYMENT_TAG"
echo "DEPLOYMENT_DOCKER_ORGANISATION: $DEPLOYMENT_DOCKER_ORGANISATION"
echo "DEPLOY_FROM_BRANCH: $DEPLOY_FROM_BRANCH"
echo "DEPLOYMENT_SHOULD_RUN: $DEPLOYMENT_SHOULD_RUN"

fi
fi
fi
fi
fi
