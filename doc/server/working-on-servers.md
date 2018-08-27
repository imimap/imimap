


ssh deployer@imi-map-staging.f4.htw-berlin.de

docker-compose -f docker-compose-production.yml exec imimap bash

## Server neu starten

docker-compose -f docker-compose-production.yml down

Umgebungsvariablen setzen: (LDAP und insbesondere der RAILS_MASTER_KEY dürfen
  niemals in einem Repository veröffentlicht werden!)

export RAILS_MASTER_KEY=
export LDAP=
export TAG=
