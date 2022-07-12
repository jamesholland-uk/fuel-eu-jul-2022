#
# Creating an address object and a security policy rule in Panorama using Terraform
#
# Note: Define the values for the variables during runtime, they are not stored in this file
#

# Provider Section

terraform {
  required_providers {
    panos = {
      source  = "paloaltonetworks/panos"
      version = "~> 1.10.0"
    }
  }
}
provider "panos" {}


# Variable Section

variable "devicegroup" {}
variable "rulename" {}
variable "sourcezone" {}
variable "sourceaddress" {}
variable "destinationzone" {}
variable "destinationaddressname" {}
variable "destinationaddressdesc" {}
variable "destinationaddressIP" {}
variable "application" {}
variable "port" {}
variable "securityprofilegroup" {}
variable "comment" {}


# Configuration Section

resource "panos_address_object" "the-address-object" {
  device_group = var.devicegroup
  name         = var.destinationaddressname
  value        = var.destinationaddressIP
  description  = var.destinationaddressdesc
}

resource "panos_panorama_security_rule_group" "the-rule" {
  device_group = var.devicegroup
  rule {
    name                  = var.rulename
    source_zones          = [var.sourcezone]
    source_addresses      = [var.sourceaddress]
    source_users          = ["any"]
    destination_zones     = [var.destinationzone]
    destination_addresses = [panos_address_object.the-address-object.name]
    categories            = ["any"]
    applications          = [var.application]
    services              = [var.port]
    action                = "allow"
    group                 = var.securityprofilegroup
    description           = var.comment
  }
}
