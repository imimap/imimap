
## Repositories & Travis CI
### Current Main Repository with CI/CD:
* [https://github.com/imimaps/imimaps](https://github.com/imimaps/imimaps)
* [![Build Status](https://travis-ci.org/imimaps/imimaps.svg?branch=master)](https://travis-ci.org/imimaps/imimaps)
* [Branch and Stages Overview on Travis CI](https://travis-ci.org/imimaps/imimaps/branches)

## General Project Info
The [IMI Map](http://imi-map.f4.htw-berlin.de) supports students at the University of Applied Sciences Berlin in finding an internship abroad.

It is an ongoing project developed in different projects and individual thesis work
by students of the Bachelor's Programme International Media Informatics at HTW Berlin.

# How to contribute

## Local Installation

- email kleinen at htw-berlin.de for access rights.
- clone the repository, e.g.

    git clone git@github.com:imimaps/imimaps.git

    cd imimaps

Starting the server:

    bundle install
    rake db:migrate
    rake db:seed
    rails server  

Testing:

    rake db:migrate RAILS_ENV=test
    rspec spec

Local Development is discouraged. If you do it nonetheless, be careful not to
commit db/schema.rb files generated with a migration against a SQLITE database.

You need the same commands using docker, however:

## Local dev and test environment using Docker

Start the Postgres and IMI-Map Containers:

    docker-compose up
    docker exec -ti imimap-dev bash

You then get a bash prompt from within the docker container and can execute all
of the rails commands that you would execute locally.

For testing, you can also just call the tests that travis calls:

    ./ci-cd/travis-test.sh

Note that they too run in the imimap-dev container.

There are many different ways of working with the docker containers. Refer to the
Docker and docker-compose documentation




# More on Deployment

see .docker/docs.md

## Production and Deployment

The Staging host is available at: [https://imi-map-staging.f4.htw-berlin.de](https://imi-map-staging.f4.htw-berlin.de)

Deployment is done via docker. This is documentation on how to test
the production image locally: [./docker/set-up-staging-production.md](https://github.com/imimaps/imimaps/blob/master/.docker/set-up-staging-production.md)

# Generated Documentation

Two gems are used to generate documentation: society and railroady.

## Society

## Railroady
* [Railroady on Github](https://github.com/preston/railroady)
