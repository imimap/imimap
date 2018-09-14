# These are the ip-tables how docker created them if allowed to:

root@imi-map-staging:~# iptables --list
Chain INPUT (policy ACCEPT)
target     prot opt source               destination

Chain FORWARD (policy ACCEPT)
target     prot opt source               destination
DOCKER-ISOLATION  all  --  anywhere             anywhere
ACCEPT     all  --  anywhere             anywhere             ctstate RELATED,ESTABLISHED
DOCKER     all  --  anywhere             anywhere
ACCEPT     all  --  anywhere             anywhere
ACCEPT     all  --  anywhere             anywhere
ACCEPT     all  --  anywhere             anywhere             ctstate RELATED,ESTABLISHED
DOCKER     all  --  anywhere             anywhere
ACCEPT     all  --  anywhere             anywhere
ACCEPT     all  --  anywhere             anywhere

Chain OUTPUT (policy ACCEPT)
target     prot opt source               destination

Chain DOCKER (2 references)
target     prot opt source               destination
ACCEPT     tcp  --  anywhere             172.18.0.2           tcp dpt:postgresql
ACCEPT     tcp  --  anywhere             172.18.0.3           tcp dpt:http

Chain DOCKER-ISOLATION (1 references)
target     prot opt source               destination
DROP       all  --  anywhere             anywhere
DROP       all  --  anywhere             anywhere
RETURN     all  --  anywhere             anywhere
root@imi-map-staging:~#




# Production - eingeschaltete Firewall

deployer@imi-map-production:~$ sudo -i
root@imi-map-production:~# iptables --list
Chain INPUT (policy ACCEPT)
target     prot opt source               destination
ACCEPT     all  --  anywhere             anywhere             state RELATED,ESTABLISHED
ACCEPT     tcp  --  anywhere             anywhere             tcp dpt:ssh
ACCEPT     tcp  --  anywhere             anywhere             tcp dpt:https
ACCEPT     tcp  --  anywhere             anywhere             tcp dpt:http
ACCEPT     all  --  anywhere             anywhere
DROP       all  -- !141.45.0.0/16        anywhere
ACCEPT     icmp --  anywhere             anywhere
ACCEPT     tcp  --  anywhere             anywhere             tcp dpt:ssh
DROP       all  --  anywhere             anywhere

Chain FORWARD (policy DROP)
target     prot opt source               destination
ACCEPT     all  --  anywhere             anywhere
ACCEPT     all  --  anywhere             anywhere

Chain OUTPUT (policy ACCEPT)
target     prot opt source               destination
ACCEPT     all  --  anywhere             anywhere             state RELATED,ESTABLISHED
ACCEPT     tcp  --  anywhere             unknown.eserver-ru.com/20  tcp dpt:http
ACCEPT     tcp  --  anywhere             141.45.144.0/20      tcp dpt:ldap
ACCEPT     udp  --  anywhere             141.45.144.0/20      udp dpt:ldap
ACCEPT     tcp  --  anywhere             141.45.144.0/20      tcp dpt:ldaps
ACCEPT     udp  --  anywhere             141.45.144.0/20      udp dpt:ldaps
ACCEPT     tcp  --  anywhere             anywhere             tcp dpt:ssh
ACCEPT     tcp  --  anywhere             anywhere             tcp dpt:https
ACCEPT     tcp  --  anywhere             anywhere             tcp dpt:http
ACCEPT     all  --  anywhere             anywhere
DROP       all  --  anywhere            !141.45.0.0/16
ACCEPT     icmp --  anywhere             anywhere
ACCEPT     udp  --  anywhere             anywhere             udp dpt:domain
ACCEPT     udp  --  anywhere             anywhere             udp dpt:ntp
ACCEPT     tcp  --  anywhere             anywhere             tcp dpt:ntp
DROP       all  --  anywhere             anywhere

Chain DOCKER (0 references)
target     prot opt source               destination

# nach aussschalten der Firewall:

root@imi-map-production:~# iptables --list
Chain INPUT (policy ACCEPT)
target     prot opt source               destination

Chain FORWARD (policy ACCEPT)
target     prot opt source               destination

Chain OUTPUT (policy ACCEPT)
target     prot opt source               destination

Chain DOCKER (0 references)
target     prot opt source               destination
