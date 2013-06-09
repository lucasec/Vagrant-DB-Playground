#!/usr/bin/env bash

if [ ! -e '.vg-setup-done' ]; then

	echo "Updating package repository"
	apt-get -qq update > /dev/null 2>&1
	echo "Installing PostgreSQL and Apache..."
	apt-get install -y apache2 php5 libapache2-mod-php5 php5-mcrypt php5-pgsql postgresql postgresql-contrib
	sed -i 's/AllowOverride None/AllowOverride All/g' /etc/apache2/sites-available/default > /dev/null 2>&1
	sed -i 's/AllowOverride None/AllowOverride All/g' /etc/apache2/sites-available/default-ssl > /dev/null 2>&1
	a2enmod rewrite > /dev/null 2>&1
	service apache2 restart > /dev/null 2>&1

	echo "Downloading phpPgAdmin..."
	wget --trust-server-name -q "http://downloads.sourceforge.net/project/phppgadmin/phpPgAdmin%20%5Bstable%5D/phpPgAdmin-5.1/phpPgAdmin-5.1.tar.gz?r=http%3A%2F%2Fphppgadmin.sourceforge.net%2Fdoku.php%3Fid%3Ddownload&ts=1370768524&use_mirror=hivelocity"
	rm -rf /var/www && mkdir /var/www
	tar -xvf phpPgAdmin-5.1.tar.gz -C /var/www > /dev/null
	sed -i "s/\['host'] = '';/\['host'] = 'localhost';/g" /var/www/phpPgAdmin-5.1/conf/config.inc.php
	echo "<?php header('Location: phpPgAdmin-5.1');  ?>" > /var/www/index.php
	rm phpPgAdmin-5.1.tar.gz

	touch .vg-setup-done
	echo "...installed!"

fi

echo -e "Ready!\n"

echo "----------"
echo "Create database, type 'createdb [dbname]'"
echo -e "For PostgreSQL shell, type 'psql [dbname]'\n"
echo "Web admin: port 8080, user: vagrant, passwd: vagrant"
echo -e "----------\n"
