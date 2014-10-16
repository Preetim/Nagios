#!/bin/sh
sudo apt-get -y install apache2
sudo apt-get update
sudo apt-get -y install libapache2-mod-php5
sudo apt-get -y install build-essential
sudo apt-get -y install libgd2-xpm-dev
sudo /usr/sbin/useradd -m -s /bin/bash nagios

sudo /usr/sbin/groupadd nagcmd
sudo /usr/sbin/usermod -a -G nagcmd nagios
sudo /usr/sbin/usermod -a -G nagcmd www-data

wget http://prdownloads.sourceforge.net/sourceforge/nagios/nagios-3.2.3.tar.gz
wget https://www.nagios-plugins.org/download/nagios-plugins-1.5.tar.gz
tar xzf nagios-3.2.3.tar.gz
tar xzf nagios-plugins-1.5.tar.gz
cd nagios-3.2.3
./configure --with-command-group=nagcmd
sudo apt-get install make
sudo make all
sudo make install

sudo make install-init

sudo make install-config

sudo make install-commandmode
cd /home/vagrant/nagios-3.2.3
sudo make install-webconf
sudo /etc/init.d/apache2 reload
cd /home/vagrant/nagios-plugins-1.5
sudo ./configure --with-nagios-user=nagios --with-nagios-group=nagios
sudo make
sudo make install

sudo ln -s /etc/init.d/nagios /etc/rcS.d/S99nagios
sudo /etc/init.d/nagios start
sudo htpasswd -s -c -b /usr/local/nagios/etc/htpasswd.users nagiosadmin nagiosadmin
sudo chcon -R -h root:object_r:httpd_sys_content_t /usr/local/nagios