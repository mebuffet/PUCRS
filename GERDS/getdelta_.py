from pysnmp.hlapi import *
from time import sleep

import get_

def Getdelta(options):
    if (options.public):
        comm = 'public'
    elif not (options.community == None):
        comm = options.community

    values = []

    for i in range(options.NA):
        id = ObjectIdentity(options.getdelta)

        command = getCmd(SnmpEngine(),\
                        CommunityData(comm),\
                        UdpTransportTarget((options.target, 161)),\
                        ContextData(), ObjectType(id))

        errorIndication, errorStatus, errorIndex, varBinds = next(command)

        if errorIndication:
            print(errorIndication)
        elif errorStatus:
            print('%s at %s' % (errorStatus.prettyPrint(),
                                  errorIndex and varBinds[int(errorIndex) - 1][0] or '?'))
        else:
            err = False
            for varBind in varBinds:
                oid, value = varBind
                try:
                    values.append(int(value.prettyPrint()))
                except:
                    print('SNMP object is not a integer')
                    err = True
                    break
            if err : break

        sleep(options.NT)

    for i in range(len(values) - 1):
        delta = values[i+1] - values[i]
        print(delta)
