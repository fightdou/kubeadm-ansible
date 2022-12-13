#!/usr/bin/bash
iptables -P FORWARD ACCEPT
echo 0 > /proc/sys/net/bridge/bridge-nf-call-iptables
