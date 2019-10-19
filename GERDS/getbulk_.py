from pysnmp.hlapi import *

import get_

def Getbulk(options):
    if (options.public):
        comm = 'public'
    elif not (options.community == None):
        comm = options.community

    lstOIDs = ParseBulkOIDs(options.getbulk)

    nr = int(options.NR)
    for oid in lstOIDs:
        if (nr > 0):
            command = nextCmd(SnmpEngine(), CommunityData(comm),\
                     UdpTransportTarget((options.target, 161)),\
                     ContextData(), ObjectType(ObjectIdentity(oid)))
            errorIndication, errorStatus, errorIndex, varBinds = next(command)

            if errorIndication:
                print(errorIndication)
            elif errorStatus:
                print('%s at %s' % (errorStatus.prettyPrint(), errorIndex and varBinds[int(errorIndex) - 1][0] or '?'))
            else:
                for varBind in varBinds:
                    print(' = '.join([x.prettyPrint() for x in varBind]))
            nr = nr - 1
        else:
            oid2 = oid
            for j in range(int(options.NC)):
                command = nextCmd(SnmpEngine(), CommunityData(comm),\
                     UdpTransportTarget((options.target, 161)),\
                     ContextData(), ObjectType(ObjectIdentity(oid2)))

                errorIndication, errorStatus, errorIndex, varBinds = next(command)

                if errorIndication:
                    print(errorIndication)
                elif errorStatus:
                    print('%s at %s' % (errorStatus.prettyPrint(),
                                          errorIndex and varBinds[int(errorIndex) - 1][0] or '?'))
                else:
                    for varBind in varBinds:
                        id, value = varBind
                        oid2 = id
                        print(' = '.join([x.prettyPrint() for x in varBind]))

def ParseBulkOIDs(str):
    str = str.replace('[','')
    str = str.replace(']','')
    lst = str.split(',')
    return lst
