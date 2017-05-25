echo "start: deploy04-docker-push.sh"
docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
docker push $DEPLOYMENT_DOCKER_ORGANISATION/$DEPLOYMENT_ENVIRONMENT:$DEPLOYMENT_TAG
echo "end: deploy04-docker-push.sh"
