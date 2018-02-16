# this should be the only file in the deployment process handling environment variables.
echo "----------------- TRAVIS ENVIRONMENT ------------------"

export DEPLOYMENT_PIPELINE=HTW
export DEPLOYMENT_DOCKER_ORGANISATION=imimap

echo "TRAVIS_TAG: [${TRAVIS_TAG}]"

if [ -z "$TRAVIS_TAG" ]; then
  export set DEPLOYMENT_TAG=$(echo $TRAVIS_COMMIT | head -c 7)
else
  echo "Travis Tag was set, using as deployment Tag"
  export set DEPLOYMENT_TAG=$TRAVIS_TAG
fi
