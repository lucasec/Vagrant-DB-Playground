#!/usr/bin/env bash

if [ ! -e '.vg-setup-done' ]; then

	echo "Installing Neo4j repository..."
	wget -q -O - http://debian.neo4j.org/neotechnology.gpg.key | apt-key add - > /dev/null
	echo 'deb http://debian.neo4j.org/repo stable/' > /etc/apt/sources.list.d/neo4j.list
	echo "Updating package repository"
	apt-get -qq update > /dev/null 2>&1
	echo "Installing Neo4j (enterprise edition)..."
	apt-get install -y neo4j-enterprise
	sed -i "s/#org.neo4j.server.webserver.address=0.0.0.0/org.neo4j.server.webserver.address=0.0.0.0/g" /etc/neo4j/neo4j-server.properties
	service neo4j-service restart > /dev/null 2>&1

	touch .vg-setup-done
	echo "Installed!"

fi

echo -e "Ready!\n"

echo "----------"
echo "Admin URL: http://localhost:7474/"
echo -e "----------\n"
