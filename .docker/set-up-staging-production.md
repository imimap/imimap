
# Setup der Deployment Pipeline

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

export IMIMAPS_ENVIRONMENT=docker  # set by travis build matrix in .travis.yml
export DEPLOYMENT_PIPELINE=HTW # set by travis via repository settings. If you have a fork, this can be used to disable deployment attempts.
export DOCKER_USERNAME=imimapshtw # set by secret env variables in .travis.yml
export DOCKER_PASSWORD=<put here>

# for staging
export TRAVIS_BRANCH=master # automatically set by travis
export DEPLOYMENT_ENVIRONMENT=staging
TRAVIS_COMMIT=321xyz


# for production
export TRAVIS_TAG=0.0.5 # automatically set by travis
export TRAVIS_BRANCH=0.0.5 # automatically set by travis
export DEPLOYMENT_ENVIRONMENT=production
