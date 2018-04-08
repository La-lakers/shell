#!/bin/bash

ROOTPATH=/mnt/sysroot
read -p "Input command: " CMD
until [ x"$CMD" == x"q" ];do
    CMDFILE=`which $CMD 2>/dev/null|grep -v 'alias' |grep -o "[^[:space:]].*"`
    if [ $? -eq 0 ] ;then
        CMDPATH=`dirname $CMDFILE`
        [ ! -f $ROOTPATH/$CMDPATH ] && mkdir -p $ROOTPATH/$CMDPATH
        [ ! -f $ROOTPATH/$CMDFILE ] && cp $CMDFILE $ROOTPATH/$CMDPATH && echo "copy $CMD finished"
        for LIBFILE in `/usr/bin/ldd $CMDFILE | grep -o "/.*lib\(64\)/.*[[:space:]]"`;do 
            LIBPATH=`dirname $LIBFILE`
            [ ! -f $ROOTPATH/$LIBPATH ] && mkdir -p $ROOTPATH/$LIBPATH
            [ ! -f $ROOTPATH/$LIBFILE ] && cp $LIBFILE $ROOTPATH/$LIBPATH && echo -e "\tcopy $LIBFILE finished"
        done
        read -p "Input command: " CMD
    else
        read -p "The command wrong agein try please:" CMD
    fi
done
