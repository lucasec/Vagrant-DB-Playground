#!/usr/bin/env bash
echo "Stopping Riak DEV nodes..."
cd /home/vagrant/riak-1.3.1/dev

./dev1/bin/riak stop > /dev/null
./dev2/bin/riak stop > /dev/null
./dev3/bin/riak stop > /dev/null