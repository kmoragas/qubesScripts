# ON VPN machine I added:
# echo "iptables -I FORWARD 2 -s 10.137.6.219 -d 192.168.19.0/24 -j ACCEPT" >> /rw/config/qubes-firewall-user-script

VM=personal
BACKEND_DOMAIN=vpn
IP=10.137.6.179
NETMAKS=255.255.255.0
GW=10.137.6.1
NETWORK=192.168.54.0

qvm-start $BACKEND_DOMAIN
sudo xl network-attach $VM script=/etc/xen/scripts/vif-route-qubes ip=$IP backend=$BACKEND_DOMAIN
sleep 3
qvm-run $VM "sudo ifconfig eth1 $IP"
qvm-run $VM "sudo route add -net $NETWORK netmask $NETMASK gw $GW"
qvm-run $VM "echo 'nameserver 127.0.0.1' | sudo tee /etc/resolv.conf"

