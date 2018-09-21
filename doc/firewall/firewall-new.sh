# this might become a new firewall rules script ....
# lower part from current firewall.sh script  which persists them for server restart: 

iptables-save > /etc/firewall.conf
#
echo -n "#"      > /etc/network/if-up.d/iptables
echo -n !       >> /etc/network/if-up.d/iptables
echo /bin/sh    >> /etc/network/if-up.d/iptables
echo "iptables-restore < /etc/firewall.conf" >> /etc/network/if-up.d/iptables
#
chmod +x /etc/network/if-up.d/iptables
