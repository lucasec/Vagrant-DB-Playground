#!/usr/bin/env bash

if [ ! -e '.vg-setup-done' ]; then

	echo "Updating package repository"
	apt-get -qq update > /dev/null 2>&1
	echo "Installing CouchDB..."
	apt-get install -y couchdb
	echo "Configuring CouchDB..."
	sed -i "s/;bind_address = 127.0.0.1/bind_address = 192.168.33.12/g" /etc/couchdb/local.ini
	service couchdb restart > /dev/null 2>&1

	touch .vg-setup-done
	echo "Installed!"

fi

echo -e "Ready!\n"

echo "----------"
echo "Access server at http://192.168.33.12:5984/"
echo "Futon URL: http://192.168.33.12:5984/_utils/"
echo -e "----------\n"
