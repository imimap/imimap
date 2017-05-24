
# Setup der Deployment Pipeline

### Github setup
Restrictions on Master Branch are set via github branch configuration page
 https://github.com/imimaps/imimaps/settings/branches/master


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
```
➜  imimaps_keys tree
.
|-- id_rsa_production
|-- id_rsa_production.pub
|-- id_rsa_staging
`-- id_rsa_staging.pub
```
Hat man die Keys generiert, werden diese mittels `tar cvf ssh_keys.tar` in ein Tar-Archiv gepackt,
welches dann mit dem Command
```
travis encrypt-file -r "imimaps/imimaps" ssh_keys.tar
```
von Travis spezifisch für das Git-Repository verschlüsselt wird. Die resultierende Datei `ssh_keys.tar.enc` muss dann committet werden.

**Achtung:** Weder die Keys selbst noch das unverschlüsselte Tar-Archiv dürfen nach GitHub gelangen, da das Repository öffentlich zugänglich ist.
