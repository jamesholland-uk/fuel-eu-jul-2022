#!/bin/bash

#
# Revert configuration back to running config, removes candidate config
#

curl -ksd "key=$apikey&type=op&cmd=<revert><config/></revert>" https://$host/api -w "\n" | xmllint --format -
