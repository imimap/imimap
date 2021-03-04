# Showing docker limits in deployment

BK, 4.3.2021

Docker Hub introduced limits for image downloads last November.

Each build pulls various images from docker hub, this is done unauthorized.

Step 1: Build in output of limits in ci-cd/travis-test.sh as described in
https://docs.docker.com/docker-hub/download-rate-limit/


RateLimit-Limit: 100;w=21600
RateLimit-Remaining: 65;w=21600

RateLimit-Limit: 100;w=21600
RateLimit-Remaining: 68;w=21600

## Tools/New Dependency

### JQ: command line JSON processor
https://stedolan.github.io/jq/

Local installation on MacOS:

    brew install jq

### JWT

https://github.com/mike-engel/jwt-cli

Local installation on MacOS:

    brew tap mike-engel/jwt-cli
    brew install jwt-cli

https://www.docker.com/blog/checking-your-current-docker-pull-rate-limits-and-status/
