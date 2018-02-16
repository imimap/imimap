#!/bin/bash
echo "DEPLOYMENT_ENVIRONMENT: $DEPLOYMENT_ENVIRONMENT"
echo "DEPLOYMENT_TAG: $DEPLOYMENT_TAG"
echo "DEPLOYMENT_DOCKER_ORGANISATION: $DEPLOYMENT_DOCKER_ORGANISATION"
echo "TRAVIS_BRANCH [${TRAVIS_BRANCH}]"
echo "TRAVIS_TAG [${TRAVIS_TAG}]"
echo "TRAVIS_COMMIT [${TRAVIS_COMMIT}]"
echo "TRAVIS_PULL_REQUEST" [${TRAVIS_PULL_REQUEST}]
echo "TRAVIS [${TRAVIS}]"
echo "DEPLOYMENT_SHOULD_RUN ["$DEPLOYMENT_SHOULD_RUN"]"
