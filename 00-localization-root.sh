#!/bin/bash
echo "in ROOT ausführen"
sudo su
echo "LANG=de_DE.UTF-8" > /etc/locale.conf
echo "LC_DATE=de_DE.UTF-8" >> /etc/locale.conf
echo "LC_NUMERIC=de_DE.UTF-8" >> /etc/locale.conf
echo "LC_TIME=de_DE.UTF-8" >> /etc/locale.conf
echo "KEYMAP=de-latin1" > /etc/vconsole.conf
echo "FONT=lat2-16" >> /etc/vconsole.conf
echo "FONT_MAP=8859-2" >> /etc/console.conf
rm /etc/localtime
ln -s /usr/share/zoneinfo/Europe/Berlin /etc/localtime
timedatectl set-local-rtc 0
sed -i 's/#de_DE.UTF-8\ UTF-8/de_DE.UTF-8\ UTF-8/' /etc/locale.gen
locale-gen
localectl --no-convert set-keymap de-latin1
exit 0
