
echo "$0: building docker image"

export DEPLOYMENT_ENVIRONMENT=staging

. ./ci-cd/deploy01-settings.sh
. ./ci-cd/deploy00-echo-settings.sh

echo "---------------------- calling docker build ----------------------"

docker pull imimap/imimap:$DEPLOYMENT_TAG

return_code=$?
if [ $return_code != 0 ]; then
  echo "IMAGE with tag does not yet exist; building"
  echo ${imimap/imimap:$DEPLOYMENT_TAG}

  docker build -f Dockerfile.production --build-arg RAILS_MASTER_KEY=$RAILS_MASTER_KEY  -t imimap/imimap:$DEPLOYMENT_TAG .
  return_code=$?
  if [ $return_code != 0 ]; then
    echo "FAILED: docker build"
    exit $return_code
  fi

fi



echo "--- docker images ---"
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
