
ssh deployer@imi-map-staging.f4.htw-berlin.de
ssh deployer@imi-map-production.f4.htw-berlin.de

less /etc/nginx/sites-enabled/default

sudo -i
service nginx restart
