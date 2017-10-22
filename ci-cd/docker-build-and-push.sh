
echo "$0: building docker image"

export DEPLOYMENT_ENVIRONMENT=production

. ./ci-cd/deploy01-settings.sh
. ./ci-cd/deploy00-echo-settings.sh

if [ $DEPLOYMENT_SHOULD_RUN != "true" ]; then
  echo "***** SKIPPING BUILD AND PUSH: DEPLOYMENT_SHOULD_RUN $DEPLOYMENT_SHOULD_RUN *****"
  echo "end $0"
  exit 0
fi


docker build -f Dockerfile.production -t imimap/imimap:$DEPLOYMENT_TAG .

return_code=$?
if [ $return_code != 0 ]; then
  echo "FAILED: docker build"
  exit $return_code
fi

docker images
echo "pushing image with tag imimap/imimap:$DEPLOYMENT_TAG"


docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
docker push imimap/imimap:$DEPLOYMENT_TAG

return_code=$?
if [ $return_code != 0 ]; then
  echo "FAILED: docker push"
  exit $return_code
fi

echo "end $0"
