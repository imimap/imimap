# Docker and IPTables

Docker modifies the iptables on startup. We use IPTables as a firewall on our
servers.

Docker opens exported ports to the world by adding rules to the FORWARD chain.
This does also make the Database available to the public. Not good.

## How IP Tables work

IP Tables have three chains, INPUT, OUTPUT and FORWARD.
Rules can be added to a chain with

    iptables -A <chain> <rule-specifications>

e.g.

    iptables -A INPUT -p tcp -m tcp --dport 22 -j ACCEPT

to allow incomming ssh connections on port 22. Note that most protocols need a
backchannel, this is done by

    iptables -A OUTPUT -m state --state RELATED,ESTABLISHED -j ACCEPT

which allows incoming packets on an established connection.

    iptables -A OUTPUT -d 141.45.144.0/20 -p tcp -m tcp --dport 636 -j ACCEPT
    iptables -A OUTPUT -d 141.45.144.0/20 -p udp -m udp --dport 636 -j ACCEPT

allow outgoing connections to the ldap server; again,

    iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT

is necessary for the answers.

Docker uses the user-defined chains DOCKER and DOCKER-ISOLATION.
user-defined chains can be referenced as a so called "target" (instead of ACCEPT
  or DROP) and are basically a kind of go to. After completion of the chain
  the other rules are handled.

    iptables -A FORWARD -j DOCKER-ISOLATION

As soon as a rule matches, the the "jump" (-j) is executed, in case of
ACCEPT or DROP no further rules are evaluated.

Thus, more specific rules need to come first in the chain.

A last rule of

    iptables -A INPUT -j DROP

is equivalent to setting the policy of the chain to drop

    iptables -P INPUT DROP

- if no rule matched until the end of the chain, the packet is dropped. (Or accepted).

## Modification of IP Tables by docker

Docker modifies the iptables to achieve connectivity between and to containers.

This can be switched off by editing the file

    /etc/systemd/system/docker.service.d/noiptables.conf

By setting the start parameter iptables accodingly:
ExecStart=/usr/bin/docker daemon -H fd:// --iptables=true

The docker demon needs to be restarted to have this change take effect:

     systemctl daemon-reload
     systemctl restart docker

## Restarting the containers on the machine

    docker-compose -f docker-compose-production.yml down

    docker-compose -f docker-compose-production.yml up -d

For this to work properly, some ENV variables need to be set. Alternatively,
a new deployment can be triggered from Travis. This also provides these variables.

    export RAILS_MASTER_KEY=verysecret
    export LDAP='mars.wh.f4.htw-berlin.de|636|obscureconnectstring'
    export TAG=0.0.21


## Testing the connectivity

    nc -zv mars.wh.f4.htw-berlin.de 636
    nc -zv api.google.com 80
    nc -zv postgresql 5432

    docker exec -ti imimap nc -zv mars.wh.f4.htw-berlin.de 636
    docker exec -ti imimap nc -zv api.google.com 80
    docker exec -ti imimap nc -zv postgresql 5432

So, the goal is to
  - ensure db access from imimap
  - be able to connect to external services, currently ldap and google geocoder

without opening everything, especially the database to the public

# Tried Approaches that did not work
## Using DOCKER-USER chain (did not work)

[Docker and iptables](https://docs.docker.com/network/iptables/) suggestes that it is possible
to add rules to DOCKER-USER chain which will be inserted before the DOCKER Table.



    iptables -I DOCKER-USER -i ext_if ! -s 192.168.1.1 -j DROP



         vi /etc/systemd/system/docker.service.d/noiptables.conf
         systemctl daemon-reload
         systemctl restart docker

## Deleting rules after Docker has created them (did not work)

one approach could be to delete/alter rules after docker created them.
Probably mostly useful for tinkering/testing, as the alteration would be needed to
iptables -D DOCKER -d 172.18.0.2/32 ! -i br-9f85b4780d41 -o br-9f85b4780d41 -p tcp -m tcp --dport 5432 -j ACCEPT

There are two problems with this approach:

## Manually creating the IP Tables (not finished, might work)

There is not really a documentation on what has to be done for creating the
IP Tables manually with docker, [Docker and iptables](https://docs.docker.com/network/iptables/)
merely warns that it is complicated (with a link to an extra complicated
documentation).

It might work to take the generated rules as an example and extract general
rules from them. The generated rules contain dynamically assigned network
adapter names. IPs for containers can be assigned in docker-composed which
might help creating those rules, not sure about network adapter names.


# Temporary Solution

Re-Reading
[Container networking](https://docs.docker.com/config/containers/container-networking/)
in the Docker Documentation made me realize that we might not need to expose the
postgres port to the outside world, and indeed, we need not.

When Docker manipulates the IP Tables, it now doesn't open postgres to the world.

It has a caveat, though: after the firewall rules in firewall.sh have been established,
both containers need to be stopped and restarted (see the difference between the
resulting in iptables/vor-restart-pg.txt and iptables/nach-restart-pg.txt).

I've altered the deployment script to do a docker-compose down.


# Links

Server Documentation in the Wiki

https://wiki.htw-berlin.de/confluence/display/fb4imimap/IMI-Map+staging+server



# Further Ideas


## Put NGINX in a Docker Container

see
https://docs.docker.com/samples/library/nginx/

When we introduced docker, this question came up: why doesn't nginx run in a
container? Now there might be a reason: if nginx runs in the docker network,
the rails server port does not be exposed outside of docker.

This might make the Temporary Solution more viable and maybe not that temporary.
