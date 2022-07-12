import panos
import os

from panos import policies, objects, panorama
from panos.panorama import Panorama, DeviceGroup
from panos.objects import AddressObject
from panos.policies import PreRulebase, SecurityRule

#
# Creating an address object and a security policy rule in Panorama using the pan-os-python SDK
#
# Note: Define the values for the variables during runtime, they are not stored in this file
#


def main():

    # Define connectivity to Panorama through environment variables
    hostname = os.environ.get("host")
    api_key = os.environ.get("apikey")
    panorama = Panorama(hostname=hostname, api_key=api_key)

    # Define Device Group & Rulebase
    devicegroup = os.environ.get("devicegroup")
    dg = DeviceGroup(devicegroup)
    panorama.add(dg)
    prerulebase = PreRulebase()
    dg.add(prerulebase)

    # Gather input values
    rulename = os.environ.get("rulename")
    sourcezone = os.environ.get("sourcezone")
    sourceaddress = os.environ.get("sourceaddress")
    destinationzone = os.environ.get("destinationzone")
    destinationaddressIP = os.environ.get("destinationaddressIP")
    destinationaddressname = os.environ.get("destinationaddressname")
    destinationaddressdesc = os.environ.get("destinationaddressdesc")
    application = os.environ.get("application")
    port = os.environ.get("port")
    securityprofilegroup = os.environ.get("securityprofilegroup")
    comment = os.environ.get("comment")

    # Add address object
    addressobject = AddressObject(
        name=destinationaddressname,
        value=destinationaddressIP,
        description=destinationaddressdesc,
    )
    dg.add(addressobject)
    addressobject.create()

    # Add a rule to Pre Rules
    prerule = SecurityRule(
        name=rulename,
        fromzone=[sourcezone],
        tozone=[destinationzone],
        source=[sourceaddress],
        destination=[destinationaddressname],
        application=[application],
        service=[port],
        action="allow",
        group=securityprofilegroup,
        description=comment,
    )
    prerulebase.add(prerule)
    dg.add(prerulebase)
    prerulebase.create()


if __name__ == "__main__":
    main()
