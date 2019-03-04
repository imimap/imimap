#!/bin/bash
# set by travis - repository settings
export DEPLOY_FROM_BRANCH=master
export DEPLOYMENT_PIPELINE=HTW

# set by travis
export TRAVIS_BRANCH=master
export TRAVIS_TAG=
export TRAVIS_COMMIT=8824486c739fb924af89e4aeec674e4295c85454
export TRAVIS_PULL_REQUEST=false # number or false
export TRAVIS=true

# set by travis.yml
export IMIMAPS_ENVIRONMENT=docker

# set as an parameter to or directly in the script
export DEPLOYMENT_ENVIRONMENT=production
