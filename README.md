[![Build Status](https://travis-ci.org/imimap/imimap.svg?branch=master)](https://travis-ci.org/imimap/imimap)
 [![Codacy Badge](https://api.codacy.com/project/badge/Grade/d9901844daae46f3aceea4dbf493d034)](https://www.codacy.com/app/kleinen/imimap?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=imimap/imimap&amp;utm_campaign=Badge_Grade)

## Repositories & Travis CI

### Current Main Repository with CI/CD:

* [Travis Build History](https://travis-ci.org/imimap/imimap/builds)
* [https://github.com/imimap/imimap](https://github.com/imimap/imimap)
* [Branch and Stages Overview on Travis CI](https://travis-ci.org/imimap/imimap/branches)

## Servers
* [Production](http://imi-map.f4.htw-berlin.de)
* [Staging](http://imi-map-staging.f4.htw-berlin.de)
## General Project Info
The [IMI Map](http://imi-map.f4.htw-berlin.de) supports students at the University of Applied Sciences Berlin in finding an internship abroad.

It is an ongoing project developed in different projects and individual thesis work
by students of the Bachelor's Programme International Media Informatics at HTW Berlin.

# How to contribute

## Local Installation

- email kleinen at htw-berlin.de for access rights.
- clone the repository, e.g.

    git clone git@github.com:imimap/imimap.git

    cd imimap

## Local dev and test environment using Docker

The IMI-Map runs in Docker Containers on production. To reproduce the production
environment for test and dev, both should be in docker, to.

### Requirements

- Docker

### Using Docker

there's a makefile containing the most frequently used docker commands for the
imimap. E.g.

    make start
    make test

starts (and downloads/builds the containers, if necessary) and runs a test (rspec)
in docker.

Note that an image rebuild is needed when the dependencies (Gemfile, Gemfile.lock)
was changed.


## Test Data for Development

    make bash
    rails db:seed

creates test data in the docker container.

s011_001 to s011_020 will be students with already one internship,
s012_001 to s012_020 will be students with no internship,
see db/seeds for details.


## Running Rails locally

    IMI-Map Development should be done within a docker container,
    local Development is discouraged. If you do it nonetheless, be careful not to
    commit db/schema.rb files generated with a migration against a SQLITE database.

    IMI-Map needs a couple of packages to be installed, refer to the Dockerfile.

    Starting the server:

        bundle install
        rake db:migrate
        rake db:seed
        rails server  

    Testing:

        rake db:migrate RAILS_ENV=test
        rspec spec

    You need the same commands using docker, however:

## Pushing to the Repository / Development Workflow

For adding a feature, follow the development workflow:

1. checkout master, pull changes (git pull origin master)
2. Create a branch
3. push the branch
4. create a pull request
5. if all tests pass, create a pull request
6. ask someone for a code review for this pull request.
7. add changes to your pull request.
8. merge the pull request yourself. Usually a merge & squash is best
9. delete the branch on github
10. after the merge, go back to 1. - don't work on your branch anymore!

Pull requests should have the issue id in their comment.
No one is allowed to push to master directly.
The master branch will be deployed to the staging server.

## Rebuild the Docker Image

After changing the Gemfile or Gemfile.lock, the docker image for imimap
needs to be rebuilt.

Changes to Gemfile and Gemfile.lock should be made with the imimap container running, such that it is possible that the gem installation succeeds in the
container.

Nevertheless, bundler may fail during the build process. To troubleshoot,
the bundler command needs to be removed from the Dockerfile.

If the rails server can't be started, the startup command can be replaced by uncommenting the simple tail command in docker-compose.override.yml - this is a simple way to override the default startup command of the container without
modifying the Dockerfile.

The container should now come up and after entering a bash within the container,
the gem installation can be troubleshooted within the container.

    docker-compose exec imimap bash

# More on Deployment

see doc subdirectory

## Production and Deployment

The Staging host is available at: [https://imi-map-staging.f4.htw-berlin.de](https://imi-map-staging.f4.htw-berlin.de)

Deployment is done via docker. This is documentation on how to test
the production image locally: [./docker/set-up-staging-production.md](https://github.com/imimaps/imimaps/blob/master/.docker/set-up-staging-production.md)

# Miscellany

## FactoryBot, Factories

Test Data for the Tests is created with the Gem "FactoryBot".
After changed to the model and/or the factories, it's usually easier to
first check on the factories and then run the test suite.

    rake factory_bot:lint

See
    * https://github.com/thoughtbot/factory_bot/blob/master/GETTING_STARTED.md

# Generated Documentation

Two gems are used to generate documentation: society and railroady.

## Society

## Railroady
* [Railroady on Github](https://github.com/preston/railroady)

# Useful commands

    docker-compose exec -T imimap rails db:drop DISABLE_DATABASE_ENVIRONMENT_CHECK=1
    docker-compose exec -T imimap rails db:create DISABLE_DATABASE_ENVIRONMENT_CHECK=1
    make import_dump file=dumps/imi-map-2019-10-28.pgdump
    rake imimap:approve_all
