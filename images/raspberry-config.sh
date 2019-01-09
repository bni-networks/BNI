#!/bin/bash

#### BNI Networks Openhab Raspberry Pi Installation

### Update system with latest security updates.  Remove old unused packages and kernals to save space.

apt-get update
apt-get upgrade
apt-get autoremove

### Disable Bluetooth on box

echo 'blacklist btbcm' >> /etc/modprobe.d/raspi-blacklist.conf
echo 'blacklist hci_uart' >> /etc/modprobe.d/raspi-blacklist.conf

### Install baseline software

apt-get install openssh-server
apt-get install vim
apt-get install apache2
apt-get install fail2ban

### Configure Apache modules

a2enmod rewrite proxy headers

### Setup apache html environment under /var/www

cd /var/www/html
mkdir css scripts

cd css
wget PATH TO SERVER WHERE FILES ARE HOUSED
cd ../scripts
wget PATH TO SERVER WHERE FILES ARE HOUSED

cd /var/www/html
chown -R www-data:www-data css scripts

### Install Openhab2

wget –q –O -https://bintray.com/user/downloadSubjectPublicKey?username=openhab' | sudo apt-key add 
apt-get install apt-transport-https

echo 'deb https://dl.bintray.com/openhab/apt-repo2 stable main' | sudo tee /etc/apt/sources.list.d/openhab2.list

apt-get update
apt-get install openhab2
apt-get install openhab2-addons

systemctl start openhab2.service
systemctl status openhab2.service
systemctl daemon-reload
systemctl enable openhab2.service

cd /
echo 'enable_uart=1' >> /boot/config.txt

cd /etc/default
rm openhab2
wget PATH TO SERVER FILES/openhab2

systemctl restart openhab2.service
systemctl status openhab2.service



### Install Razberry Daughterboard

wget – r  –O  – http://razberry.z-wave.me/install | sudo bash