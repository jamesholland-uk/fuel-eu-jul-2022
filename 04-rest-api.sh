#!/bin/bash

#
# Creating an address object and a security policy rule in Panorama using the REST API
#
# Note: Define the values for the variables during runtime, they are not stored in this file
#

# Create address object
payload="{"\"entry"\": {"\"@name"\": "\"$destinationaddressname"\","\"ip-netmask"\": "\"$destinationaddressIP"\", "\"description"\": "\"$destinationaddressdesc"\"}}"

curl "https://$host/restapi/v10.2/Objects/Addresses?location=device-group&device-group=$devicegroup&name=$destinationaddressname" -H "X-PAN-KEY: $apikey" -d "$payload" -w "\n"

# Create rule
payload="{"\"entry"\": {"\"@device-group"\": "\"$devicegroup"\","\"@location"\": "\"device-group"\","\"@name"\": "\"$rulename"\","\"action"\": "\"allow"\","\"application"\": {"\"member"\": ["\"$application"\"]},"\"destination"\": {"\"member"\": ["\"$destinationaddressname"\"]},"\"from"\": {"\"member"\": ["\"$sourcezone"\"]},"\"profile-setting"\": {"\"group"\": {"\"member"\": ["\"$securityprofilegroup"\"]}},"\"service"\": {"\"member"\": ["\"$port"\"]},"\"source"\": {"\"member"\": ["\"$sourceaddress"\"]},"\"description"\": "\"$comment"\","\"to"\": {"\"member"\": ["\"$destinationzone"\"]}}}"

curl "https://$host/restapi/v10.2/Policies/SecurityPreRules?location=device-group&device-group=$devicegroup&name=$rulename" -H "X-PAN-KEY: $apikey" -d "$payload" -w "\n"
