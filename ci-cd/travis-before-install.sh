#!/usr/bin/env bash
# travis env set DEPLOYMENT_PIPELINE dev-sector
if [ -z "$DEPLOYMENT_PIPELINE" ]; then
    echo "no DEPLOYMENT_PIPELINE set, skipping/not decripting ssh keys"
else

  if [ $DEPLOYMENT_PIPELINE == "dev-sector" ]; then
      echo "DEPLOYMENT_PIPELINE dev-sector, decrypting ssh keys"
      openssl aes-256-cbc -K $encrypted_473888976053_key -iv $encrypted_473888976053_iv -in ssh_keys.tar.enc -out ssh_keys.tar -d
      tar xvf ssh_keys.tar
      chmod 0600 id_rsa*
  else
      echo "DEPLOYMENT_PIPELINE ${DEPLOYMENT_PIPELINE} not recognized"
  fi
fi
