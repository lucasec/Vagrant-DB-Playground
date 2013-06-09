#!/usr/bin/env bash

if [ ! -e '.vg-setup-done' ]; then

	echo "Updating package repository"
	apt-get -qq update > /dev/null 2>&1
	echo "Installing Erlang and build-essential..."
	apt-get install -y erlang build-essential checkinstall git
	echo "Downloading Riak..."
	su vagrant -c "wget -q http://s3.amazonaws.com/downloads.basho.com/riak/1.3/1.3.1/riak-1.3.1.tar.gz"
	su vagrant -c "tar -xvf riak-1.3.1.tar.gz" > /dev/null
	rm riak-1.3.1.tar.gz

	echo "Building and configuring Riak..."
	cd riak-1.3.1
	su vagrant -c "make devrel DEVNODES=3" > /dev/null

	cd dev

	sed -i "s/127.0.0.1/192.168.33.10/g" dev1/etc/app.config
	sed -i "s/127.0.0.1/192.168.33.10/g" dev2/etc/app.config
	sed -i "s/127.0.0.1/192.168.33.10/g" dev3/etc/app.config

	su vagrant -c "cp /vagrant/vm-config/*-riak.sh ~/riak-1.3.1/dev"
	su vagrant -c "chmod +x ~/riak-1.3.1/dev/*-riak.sh"
	su vagrant -c "cp /vagrant/vm-config/bash_profile ~/.bash_profile"
	su vagrant -c "chmod +x ~/.bash_profile"

	touch .vg-setup-done
	echo "Installed!"

fi

su vagrant -c "~/riak-1.3.1/dev/start-riak.sh"

echo -e "Ready!\n"

echo "----------"
echo -e "You'll need to join the nodes into a cluster.\n"
echo "Server host: 192.168.33.10"
echo "Ports: 10018, 10028, 10038"
echo -e "\nStart/stop with [start|stop]-riak"
echo "Manage individual nodes: dev[x] start,..."
echo "Access node admin: dev[x]-admin join,..."
echo -e "----------\n"
