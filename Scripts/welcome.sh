#!/bin/bash

FREE_RAM=`free -m | grep Mem | awk '{print $4}'`
USER=`whoami`
UP=`uptime | awk '{print $3}'`
FILESLIST=`ls`


echo "#######################################################"
echo "Welcome $USER, it's so nice to have you here"
echo "#######################################################"
echo
echo


echo "#######################################################"
echo "You have about $FREE_RAM RAM of space left"
echo "#######################################################"
echo
echo


echo "#######################################################"
echo "$HOSTNAME is currently the host of this VM"
echo "#######################################################"
echo
echo


echo "#######################################################"
echo "This device has been up for $UP seconds"
echo "#######################################################"
echo
echo


echo "#######################################################"
echo "Here's the list of files in this directory: $FILESLIST"
echo "#######################################################"
echo
echo