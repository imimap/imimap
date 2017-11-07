
build a new production image:

    export TAG=whateveryoulike
    docker build -f Dockerfile.production -t imimap/imimap:$TAG .

startup the image:

    export SECRET_KEY_BASE=$(rake secret)
    docker-compose -f docker-compose-production.yml up


alternatively, you can start an image with a TAG available from Dockerhub,
e.g. to run the image on a production/staging server - just set the
TAG accordingly. 
