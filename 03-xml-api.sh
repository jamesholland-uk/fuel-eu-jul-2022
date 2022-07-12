#!/bin/bash

#
# Creating an address object and a security policy rule in Panorama using the XML API
#
# Note: Define the values for the variables during runtime, they are not stored in this file
#

# Create address object
curl -ksd "key=$apikey&type=config&action=set&xpath=/config/devices/entry[@name='localhost.localdomain']/device-group/entry[@name='$devicegroup']/address/entry[@name='$destinationaddressname']&element=<ip-netmask>$destinationaddressIP</ip-netmask><description>$destinationaddressdesc</description>" https://$host/api -w "\n" | xmllint --format -

# Create rule
curl -ksd "key=$apikey&type=config&action=set&xpath=/config/devices/entry[@name='localhost.localdomain']/device-group/entry[@name='$devicegroup']/pre-rulebase/security/rules/entry[@name='$rulename']&<element=<from><member>$sourcezone</member></from><source><member>$sourceaddress</member></source><to><member>$destinationzone</member></to><destination><member>$destinationaddressname</member></destination><application><member>$application</member></application><service><member>$port</member></service><action>allow</action><profile-setting><group><member>$securityprofilegroup</member></group></profile-setting><description>$comment</description>" https://$host/api -w "\n" | xmllint --format -
