
echo "$0: building docker image"

. ./ci-cd/deploy01-settings.sh
. ./ci-cd/deploy00-echo-settings.sh

if [ $DEPLOYMENT_SHOULD_RUN != "true" ]; then
  echo "***** SKIPPING BUILD AND PUSH: DEPLOYMENT_SHOULD_RUN $DEPLOYMENT_SHOULD_RUN *****"
  echo "end $0"
  exit 0
fi

docker build -t imimap/imimap:$DEPLOYMENT_TAG .

docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
docker push imimap/imimap:$DEPLOYMENT_TAG

echo "end $0"
