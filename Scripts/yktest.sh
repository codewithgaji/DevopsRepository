#!/bin/bash

LIST=$(ls)
SCRIPTLISTS=$(ls {1..14}_*)
HTTPDSTATUS=$(systemctl status httpd | grep Active | awk '{print $2}')


echo
echo "##############################################"
echo "Welcome to Mr Gaji's Bash Scripting Test"
echo "##############################################"
echo
sleep 3

echo "##############################################"
echo "Welcome to root home directory"
cd
LIST=$(ls)
echo "These are the list of files available here: $LIST"
echo "##############################################"
echo
sleep 3

echo "##############################################"
echo "Going to 'opt' directory"
cd /opt/
LIST=$(ls)
echo "These are the list of files available here: $LIST"
echo "##############################################"
echo
sleep 4


echo "##############################################"
echo "Going to scripts directory"
sleep 4

cd scripts/
LIST=$(ls)
echo "These are the list of files available here: $LIST"
sleep 2
echo

echo "Wait a second....."
sleep 3
echo "There are Bash scripts here?? Wow"
echo "Let's list them seperately...."
sleep 3
SCRIPTLISTS=$(ls {1..14}_*)

echo "These are the scripts: $SCRIPTLISTS "
echo
sleep 5


echo "##############################################"
echo "I have an idea...."
sleep 3
echo "Let's check if our Apache httpd server is running...."
echo
sleep 2
echo "Let me clear the screen first so we can see what we are doing..."
sleep 3
clear
sleep 2

echo "This is it: $HTTPDSTATUS"
echo "##############################################"
echo


if [ "$HTTPDSTATUS" == 'inactive' ]
then
        echo "HTTPD process is DEAD!!!!!!!!!!"
        sleep 1

        echo "Let me fix this...."
        sleep 2

        echo "Starting HTTPD process"
        systemctl start httpd
        sleep 2
        HTTPDSTATUS=$(systemctl status httpd | grep Active | awk '{print $2}')

        echo "New Status: $HTTPDSTATUS"
        sleep 3

        echo "HTTPD Process is ALIVEEEEEEEEEEEEEEEEEEEE, it LIVES!!!!!!"
        echo


elif    [ "$HTTPDSTATUS" == 'active' ]
then
        echo "HTTPD Process is a king, It LIVES!"
        HTTPDSTATUS=$(systemctl status httpd | grep Active | awk '{print $2}')
        echo "Status : $HTTPDSTATUS"
        sleep 1

else
        echo "It's a pleasure serving you"
fi


sleep 3
echo "ALL PROCESSES EXECUTED SUCCESSFULLY"
echo "################################################"
echo