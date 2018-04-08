#!/bin/bash

function get_choice(){
    /sbin/fdisk -l | grep "Disk /dev/"
    echo 
    read -p "please input your disk)"  DISK
    until [ x"$DISK" == x"quit" ];do
       if [ ! -b $DISK ];then
            read -p "your disk not exsist! please agein)" DISK
       else
          break
       fi
    done 
    read -p  "The disk of your choice is $DISK continue (Y|N)" CHOICE
    [ x"$CHOICE" = x"N" ] && exit 1
}

function partition(){
    echo "n
p
1

+20M
n
p
2


w" |/sbin/fdisk $1
}

function format_mount_disk(){
    /sbin/mkfs.ext4  ${DISK}1
    /sbin/mkfs.ext4  ${DISK}2
    mkdir /mnt/sysroot -p
    mkdir /mnt/boot
    
    /bin/mount ${DISK}2 /mnt/sysroot/
    /bin/mount ${DISK}1 /mnt/boot
}
get_choice
partition $DISK
format_mount_disk
