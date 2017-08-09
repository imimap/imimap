
# Setup der Deployment Pipeline

## Testing the production image locally

You can either test an image that is available from docker hub or
build an image yourself. IMI-Map Images are named

   imimap/imimap:<tag>

in either case, you need to set the TAG environment variable:

    export TAG=<tag you want to use, eg. local>

The Tag is usually the hash of the commit you want to install, images that have been uploaded by travis to docker hub are here: https://hub.docker.com/r/imimap/imimap/tags/
(you can also build your own image by using the commands used by the scripts, e.g. ci-cd/docker-build-and-push.sh)

you also need to set SECRET_TOKEN

    export SECRET_TOKEN=<secret>

you can generate a secret token with

    rake secret

to build the image:

    export TAG=`git rev-parse HEAD | head -c 7`-LOCAL
    export set SECRET_KEY_BASE=baa7a08e6afa122478c888c601024948aaf6bf9685f43c50d2e9649692eee25ed4b326e216a42439f36a581c242b8c3c538c71671771fdbf525474911d94ce02

    docker build -t imimap/imimap:$TAG -f Dockerfile.production .

    docker-compose up

    or
    docker-compose up -d


### running the image

- copy Dockerfile, docker-compose.yml (and docker-entrypoint.sh) into a seperate repository, e.g. production. Edit docker-compose.yml and add the environment variable RAILS_SERVE_STATIC_FILES=true to the imimap service (otherwise the assets wont be served, this is done by ngnix on the production server and run

    docker-compose up

After that, set up your database, if not already in place.

## Database setup

### Initial Database setup

If IMI-Map is set up on a new machine, the database needs to be created.
After the Container has started, run:

    psql --set ON_ERROR_STOP=on  -h localhost -U imi_map imi_map_production < imi-maps.pgdump

on the machine to import a database dump in imi-maps.pgdump. If necessary, delete the database files completely - they will be recreated when the docker image is started.

The database is mounted to ./postgres from where docker-compose is run.

Perform a database migration:

    docker-compose exec imimaps bundle exec rake db:migrate

    (note that TAG and SECRET_TOKEN need to be set to run docker-compose)

It's also possible to skip applying the dump, and use seed data instead.

### Github setup
Restrictions on Master Branch are set via github branch configuration page
 https://github.com/imimaps/imimaps/settings/branches/master

### Docker Hub Setup

during the deployment process docker images are built and pushed to docker-hub.
The credentials are stored in travis environment variables.

if this needs to be changed, the according docker credentials have to be made available by encrypting them and adding them to .travis.yml

travis encrypt DOCKER_USERNAME= --add
travis encrypt DOCKER_PASSWORD= --add

Currently, the organisation "imimaps" on docker hub is used, created by Simon Albrecht.


### Setup für Production- und Staging-Hosts


```
$ brew install ansible



# A user with password-less sudo has to be present on the hosts
# Copy your ssh public key to the remote host and insert it into /home/your_user_name/.ssh/authorized_keys
# customize the ansible inventory to fit your needs:

[production]
imimaps-production.dev-sector.net ansible_user=your_user_name
[staging]
imimaps-staging.dev-sector.net ansible_user=your_user_name

# Customize bootstrap_host/group_vars/{production.yml,staging.yml}
# to fit your user name and desired hostname

# Create encrypted files containing the public ssh deploy key
# bootstrap_host/group_vars{production,staging}/vault

# Contents:
vault_cicd_pubkey: your_cicd_pubkey_here

# Encrypt the vault files
$ ansible-vault encrypt bootstrap_host/group_vars/staging/vault
$ ansible-vault encrypt bootstrap_host/group_vars/production/vault
# Store your vault password in a safe place

# Firewall ausschalten

   sudo -i
   root@imi-map-staging:~# ./firewall-disable.sh


# bootstrap the host for staging
$ ansible-playbook -i inventory -l staging  playbook.yml --ask-vault-pass

# or: boostrap both hosts:
$ ansible-playbook -i inventory playbook.yml --ask-vault-pass
```

Nachdem die Production- und Staging-Hosts aufgesetzt sind, ist es notwendig, die Variablen `@deployment_user` und
`@hosts` in der Datei `ci-cd/docker-deploy.rb` anzupassen.

### Travis Deploy-Keys

Damit Travis Zugang zu den Staging- und Production-Hosts gewährt werden kann, werden zwei SSH-Key-Paare benötigt.
Diese sollten mit dem Befehl `ssh-keygen` jeweils ohne Passwort mit den Namen `id_rsa_production` und `id_rsa_staging` im selben Verzeichnis generiert werden.
Das Verzeichnis sollte wiefolgt aussehen:

    ssh-keygen

```
➜  imimaps_keys tree
.
|-- id_rsa_production
|-- id_rsa_production.pub
|-- id_rsa_staging
`-- id_rsa_staging.pub
```
Hat man die Keys generiert, werden diese  in ein Tar-Archiv gepackt:

`tar cvf ssh_keys.tar *`

welches dann mit dem Kommando (! try out --add next time)

```
travis encrypt-file -r "imimaps/imimaps" ssh_keys.tar
```

von Travis spezifisch für das Git-Repository verschlüsselt wird. Die resultierende Datei `ssh_keys.tar.enc` muss dann committet werden.

dabei wird das Kommando zum entschlüsseln generiert, das in .travis.yml eingefügt werden muss.
    openssl aes-256-cbc -K $encrypted_473888976053_key -iv $encrypted_473888976053_iv -in ssh_keys.tar.enc -out ssh_keys.tar -d


### Notes
 * sie auch  https://docs.travis-ci.com/user/encrypting-files/
 * `travis` is the cli for travis, see https://github.com/travis-ci/travis.rb#installation


**Achtung:** Weder die Keys selbst noch das unverschlüsselte Tar-Archiv dürfen nach GitHub gelangen, da das Repository öffentlich zugänglich ist.


### Testing the deployment script

# to test this script: put id_rsa keys in root (don't forget to delete them later!)
# and set the following environment variables:

export DOCKER_USERNAME=imimap # set by secret env variables in .travis.yml
export DOCKER_PASSWORD=<put here> # set by secret env variables in .travis.yml  
export IMIMAPS_ENVIRONMENT=docker # set by travis build matrix in .travis.yml
export DEPLOYMENT_PIPELINE=HTW # set by travis via repository settings. If you have a fork, this can be used to disable deployment attempts.
export TRAVIS_COMMIT=$(git log --pretty=format:'%h' -n 1)
export TRAVIS_BRANCH=docker

# for staging
export TRAVIS_BRANCH=master # automatically set by travis
export TRAVIS_COMMIT=$(git log --pretty=format:'%h' -n 1)



# for production
export TRAVIS_TAG=0.0.5 # automatically set by travis
export TRAVIS_BRANCH=0.0.5 # automatically set by travis
