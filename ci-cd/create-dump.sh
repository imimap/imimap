scp ci-cd/create-dump-on-machine.sh deployer@imi-map-production.f4.htw-berlin.de:create-dump.sh
ssh deployer@imi-map-production.f4.htw-berlin.de "./create-dump.sh"
scp deployer@imi-map-production.f4.htw-berlin.de:imi-map-$(date +%Y-%m-%d).pgdump .
