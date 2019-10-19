from pysnmp.hlapi import *

def Next(options):
    if (options.public):
        comm = 'public'
    elif not (options.community == None):
        comm = options.community

    lstOIDs = ParseOIDs(options.next)
    for id in lstOIDs:
        command = nextCmd(SnmpEngine(),\
                        CommunityData(comm),\
                        UdpTransportTarget((options.target, 161)),\
                        ContextData(), ObjectType(ObjectIdentity(id)))

        sendCommand(command)

def sendCommand(command):
    errorIndication, errorStatus, errorIndex, varBinds = next(command)

    if errorIndication:
        print(errorIndication)
    elif errorStatus:
        print('%s at %s' % (errorStatus.prettyPrint(),
                              errorIndex and varBinds[int(errorIndex) - 1][0] or '?'))
    else:
        for varBind in varBinds:
            print(' = '.join([x.prettyPrint() for x in varBind]))

def ParseOIDs(str):
    if not (str.find('[') == -1):
        str = str.replace('[','')
        str = str.replace(']','')
        lst = str.split(',')
        return lst
    else:
        return [str]
