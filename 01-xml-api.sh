#!/bin/bash

#
# Creating an address object and a security policy rule in Panorama using the XML API
#
# Note: Define the values for the "host" and "apikey" variables during runtime, they are not stored in this file
#


# Create address object
curl -ksd "key=$apikey&type=config&action=set&xpath=/config/devices/entry[@name='localhost.localdomain']/device-group/entry[@name='fuel-device-group']/address/entry[@name='web-server']&element=<ip-netmask>172.160.10.5</ip-netmask><description>app-xyz-web-server</description>" https://$host/api -w "\n" | xmllint --format -

# Create rule
curl -ksd "key=$apikey&type=config&action=set&xpath=/config/devices/entry[@name='localhost.localdomain']/device-group/entry[@name='fuel-device-group']/pre-rulebase/security/rules/entry[@name='inbound web connections']&element=<from><member>external</member></from><source><member>any</member></source><to><member>dmz</member></to><destination><member>web-server</member></destination><application><member>ssl</member></application><service><member>application-default</member></service><action>allow</action><profile-setting><group><member>fuel-security-profile-group</member></group></profile-setting><description>CC ref 1234567</description>" https://$host/api -w "\n" | xmllint --format -
