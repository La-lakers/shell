#!/bin/bash

for eth in `tail  -n +4 /proc/net/dev  |awk -F ":" '{print $1}'  | grep -v bond `;do 
    stat=`sudo ethtool  $eth | grep "Link detected" |awk  '{print $NF}'`
    if [ x"$stat" == x"yes" ];then 
        echo $eth
        sudo /sbin/ethtool -G $eth rx 4096
        sudo /sbin/ethtool -G $eth tx 4096
    fi 
done
