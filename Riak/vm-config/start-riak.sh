#!/usr/bin/env bash
echo "Starting Riak DEV nodes..."
ulimit -n 4096
cd /home/vagrant/riak-1.3.1/dev

./dev1/bin/riak start > /dev/null
./dev2/bin/riak start > /dev/null
./dev3/bin/riak start > /dev/null