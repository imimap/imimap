
#!/usr/bin/env bash
echo "$0: starting deployment for IMIMAPS_ENVIRONMENT [${IMIMAPS_ENVIRONMENT}]"

export DEPLOYMENT_ENVIRONMENT=$1

echo "DEPLOYMENT_ENVIRONMENT: [${DEPLOYMENT_ENVIRONMENT}]"
if [ -z $DEPLOYMENT_ENVIRONMENT ]; then
  echo "ERROR: no deployment environment given"
  echo "usage: $0 <environment>"
  echo "end $0"
  exit 1
fi

. ./ci-cd/deploy01-settings.sh
. ./ci-cd/deploy00-echo-settings.sh

if [ $DEPLOYMENT_PIPELINE == "HTW" ]; then
  # this is a workaround as the tag matching on travis doesn't seem to work,
  # all tags are matched.
  if [ "production" = $DEPLOYMENT_ENVIRONMENT] && [ ! -z $TRAVIS_TAG ]
    echo "not deploying to production without a tag"
  else
    echo "------ deploying tag ${DEPLOYMENT_TAG} -------  "
    ./ci-cd/deploy03-travis-decrypt-keys.sh $DEPLOYMENT_ENVIRONMENT
    . ./ci-cd/deploy05-docker-deploy.sh
  fi
else
      echo "DEPLOYMENT_PIPELINE ${DEPLOYMENT_PIPELINE} not recognized"
fi

echo "end $0"
