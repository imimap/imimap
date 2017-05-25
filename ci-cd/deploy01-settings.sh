
# this should be the only file in the deployment process handling environment variables.
echo "checking environment"
echo "TRAVIS_TAG [${TRAVIS_TAG}]"
echo "TRAVIS_BRANCH [${TRAVIS_BRANCH}]"
echo "TRAVIS [${TRAVIS}]"


if [ "$IMIMAPS_ENVIRONMENT" != "docker" ]; then
  echo "IMIMAPS_ENVIRONMENT is set to ${IMIMAPS_ENVIRONMENT}, skipping deployment"
    export set DEPLOYMENT_SHOULD_RUN=false
  exit 0
fi

if [ -z "$DEPLOYMENT_PIPELINE" ]; then
    echo "no DEPLOYMENT_PIPELINE set, skipping deployment"
    export set DEPLOYMENT_SHOULD_RUN=false
    exit 0
fi

if [ -z "TRAVIS_TAG" ]; then
  echo "no TRAVIS_TAG set, skipping deployment"
    export set DEPLOYMENT_SHOULD_RUN=false
  exit 0
fi

if [ "$DEPLOYMENT_ENVIRONMENT" == "staging" ]; then
  if [ "$TRAVIS_BRANCH" != "master" ]; then
    echo "staging will only deploy if on master branch"
    export set DEPLOYMENT_SHOULD_RUN=false
    exit 0
  fi
fi
if [ "$DEPLOYMENT_ENVIRONMENT" == "production" ]; then
  if [ "$TRAVIS_BRANCH" != "$TRAVIS_TAG" ]; then
    echo "production will only deploy from tag"
    echo "got TRAVIS_BRANCH [$TRAVIS_BRANCH] and TRAVIS_TAG [$TRAVIS_TAG]"
    export set DEPLOYMENT_SHOULD_RUN=false
    exit 0
  fi
fi

export set DEPLOYMENT_TAG=$TRAVIS_TAG
export set DEPLOYMENT_DOCKER_ORGANISATION=imimapshtw
echo "all environment checks passed:"
echo "DEPLOYMENT_ENVIRONMENT: $DEPLOYMENT_ENVIRONMENT"
echo "DEPLOYMENT_TAG: $DEPLOYMENT_TAG"
echo "DEPLOYMENT_DOCKER_ORGANISATION: $DEPLOYMENT_DOCKER_ORGANISATION"

export set DEPLOYMENT_SHOULD_RUN=true
