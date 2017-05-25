
if [ -z $TRAVIS ]; then
  echo "$0: TRAVIS not set, skipping"
  exit 0
fi
if [ $TRAVIS == "true" ]; then
  echo "$0: decrypting ssh keys"
  openssl aes-256-cbc -K $encrypted_f259336567b4_key -iv $encrypted_f259336567b4_iv -in ssh_keys.tar.enc -out ssh_keys.tar -d
  tar xvf ssh_keys.tar
  chmod 0600 id_rsa*

  echo "trying to ssh to staging"
   ssh  -i id_rsa_staging -o StrictHostKeyChecking=no deployer@imi-map-staging.f4.htw-berlin.de "pwd  ; exit"
  echo "trying to ssh to production"
   ssh  -i id_rsa_production -o StrictHostKeyChecking=no deployer@imi-map-production.f4.htw-berlin.de "pwd ; exit"

else
  echo "$0: TRAVIS not set, skipping"
fi


# note: to test this step, it can be added as an extra build stage in travis:
#- stage: decrypt keys
#  install: true # hopefully skips install
#  script: ci-cd/deploy03-travis-decrypt-keys.sh
#  env: "IMIMAPS_ENVIRONMENT=docker"
#  rvm: 2.4.1


# use this to test the keys/firewall
# echo "trying to ssh to staging"
#  ssh  -i id_rsa_staging -o StrictHostKeyChecking=no deployer@imi-map-staging.f4.htw-berlin.de "pwd  ; exit"
# echo "trying to ssh to production"
#  ssh  -i id_rsa_production -o StrictHostKeyChecking=no deployer@imi-map-production.f4.htw-berlin.de "pwd ; exit"
