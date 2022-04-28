#!/bin/bash

count=0; while [ "$count" -lt "100" ]; do
    sleep 2
    status=`ps aux | grep -v grep |grep '/usr/sbin/libvirtd'| wc -l`
    if [ $status -gt 0 ]; then
        systemctl restart collectd
        exit 0
    fi
    count=$((count + 1))
    sleep 5
done
