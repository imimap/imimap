[![Build Status](https://travis-ci.com/imimap/imimap.svg?branch=master)](https://travis-ci.com/imimap/imimap)
 [![Codacy Badge](https://api.codacy.com/project/badge/Grade/d9901844daae46f3aceea4dbf493d034)](https://www.codacy.com/app/kleinen/imimap?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=imimap/imimap&amp;utm_campaign=Badge_Grade)

## Repositories & Travis CI

### Current Main Repository with CI/CD:

* [Travis Build History](https://travis-ci.org/imimap/imimap/builds)
* [https://github.com/imimap/imimap](https://github.com/imimap/imimap)
* [Branch and Stages Overview on Travis CI](https://travis-ci.com/imimap/imimap/branches)

## Servers
* [Production](http://imi-map.f4.htw-berlin.de)
* [Staging](http://imi-map-staging.f4.htw-berlin.de)
## General Project Info
The [IMI Map](http://imi-map.f4.htw-berlin.de) supports students at the HTW University of Applied Sciences Berlin in finding an internship abroad.

It is an ongoing project developed in different projects and individual thesis work
by students of the Bachelor's and Master's Programmes International Media Informatics at HTW Berlin.

# How to contribute

## Local Installation

- email kleinen at htw-berlin.de for access rights.
- clone the repository, e.g.

    git clone git@github.com:imimap/imimap.git

    cd imimap

- local database support with sqllite has been discontinued -
  you need a postsql instance for dev and test. The default configuration uses
  the one in the docker container, see below.

## Local dev and test environment using Docker

The IMI-Map runs in docker containers on production. To reproduce the production
environment for test and dev, both should be in docker, too.

### Requirements

- Docker
- if you want to start the server locally, ruby

### Using Docker

there's a makefile containing the most frequently used docker commands for the
imimap. E.g.

    make start
    make test

starts (and downloads/builds the containers, if necessary) and runs a test (rspec)
in docker.

Note that an image rebuild is needed when the dependencies (Gemfile, Gemfile.lock)
were changed. make stop also deletes all images:

    make stop


## Test Data for Development

    make db_migrate
    make db_seed

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

    The same commands can be used in the docker container. see makefile.

## Pushing to the Repository / Development Workflow

For adding a feature, follow the development workflow:

0. Usually, you work on an issue. Create one to document your work if not there.
1. checkout head of master (e.g. git checkout master; git pull origin master)
2. Create a branch, eg. bug_123 or i_123_somename to make the connection to issue
3. push the branch
5. if all tests pass, create a pull request
6. ask someone for a code review.
7. add changes to your pull request.
8. merge the pull request yourself. Usually a merge & squash is best - make sure the commit comment on closes according issues
9. delete the branch on github
10. after the merge, go back to 1. - don't work on your branch anymore!

Pull requests should have the issue id in their comment.
No one is allowed to push to master directly.
The master branch will be deployed to the staging server automagically.

## Rebuilding and Troubleshooting the Docker Image

After changing the Gemfile or Gemfile.lock, the docker image for imimap
needs to be rebuilt.

    docker build .

or even better, delete all images which forces an rebuild on start:

    make stop; make start

Changes to Gemfile and Gemfile.lock should be made with the imimap container running,
such that it is possible that the gem installation succeeds in the container.

Nevertheless, bundler may fail during the docker build process. To troubleshoot,
the bundler command needs to be removed from the Dockerfile.

If the rails server can't be started, the startup command can be replaced leaving the
container running, allowing to manually start the server in the container:

     docker-compose up -f docker-compose-norails.yml
     make bash
     bundle exec unicorn --port 80

## Import dump

    make import file=<dump file name>

# Miscellany

## FactoryBot, Factories

Test Data for the Tests is created with the Gem "FactoryBot".
After changed to the model and/or the factories, it's usually easier to
first check on the factories and then run the test suite.

    rake factory_bot:lint

See
    * https://github.com/thoughtbot/factory_bot/blob/master/GETTING_STARTED.md
