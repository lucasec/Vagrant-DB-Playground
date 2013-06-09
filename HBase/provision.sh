#!/usr/bin/env bash

which java > /dev/null 2>&1
if [ $? -gt 0 ]; then

	echo "Installing Oracle Java Runtime Environment"
	apt-get -qq update > /dev/null 2>&1
	wget -c --no-cookies --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F" "http://download.oracle.com/otn-pub/java/jdk/6u34-b04/jre-6u34-linux-x64.bin" --output-document="jre-6u34-linux-x64.bin" > /dev/null 2>&1
	chmod u+x jre-6u34-linux-x64.bin
	./jre-6u34-linux-x64.bin > /dev/null 2>&1
	mkdir -p /usr/lib/jvm
	mv jre1.6.0_34 /usr/lib/jvm/
	update-alternatives --install "/usr/bin/java" "java" "/usr/lib/jvm/jre1.6.0_34/bin/java" 1 > /dev/null 2>&1
	update-alternatives --install "/usr/bin/javaws" "javaws" "/usr/lib/jvm/jre1.6.0_34/bin/javaws" 1 > /dev/null 2>&1

fi

if [ ! -d "hbase-0.94.6.1" ]; then

	echo "Downloading Apache HBase 0.94.6.1"
	wget -q http://apache.spinellicreations.com/hbase/hbase-0.94.6.1/hbase-0.94.6.1.tar.gz
	echo "Untaring HBase tarball"
	tar -zxf hbase-0.94.6.1.tar.gz
	echo "Configuring HBase"
	mkdir -p /data/hbase
	# overwrite conf files
	cp -rf /vagrant/vm-config/hbase-conf/* /home/vagrant/hbase-0.94.6.1/conf/ > /dev/null 2>&1
	rm hbase-0.94.6.1.tar.gz
fi

if [ ! -e ".bash_profile" ]; then
	cp /vagrant/vm-config/bash_profile /home/vagrant/.bash_profile
	chmod +x /home/vagrant/.bash_profile
fi

echo "Starting HBase"
./hbase-0.94.6.1/bin/start-hbase.sh

echo -e "Ready!\n"

echo "----------"
echo "For HBase shell, type 'hbase shell'"
echo "'start-hbase' to start, 'stop-hbase' to stop."
echo -e "----------\n"
