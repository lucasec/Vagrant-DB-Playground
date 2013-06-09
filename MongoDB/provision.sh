#!/usr/bin/env bash

which mongo > /dev/null 2>&1
if [ $? -gt 0 ]; then
	echo "Installing MongoDB from repository..."
	sudo apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10
	echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/10gen.list
	sudo apt-get update
	sudo apt-get install mongodb-10gen

	echo "MongoDB installed."

fi

echo -e "Ready!\n"

echo "----------"
echo "For MongoDB shell, type 'mongo [dbname]'"
echo -e "----------\n"
