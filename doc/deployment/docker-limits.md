# Showing docker limits in deployment

BK, 4.3.2021

Docker Hub introduced limits for image downloads last November.

Each build pulls various images from docker hub, this is done unauthorized.

Step 1: Build in output of limits in ci-cd/travis-test.sh as described in
https://docs.docker.com/docker-hub/download-rate-limit/

## Tools/New Dependency
JQ: command line JSON processor
https://stedolan.github.io/jq/
