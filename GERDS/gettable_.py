from pysnmp.hlapi import *

def Gettable(options):
    if (options.public):
        comm = 'public'
    elif not (options.community == None):
        comm = options.community

    collumns = []
    lines = []
    values = []

    for (errorIndication, errorStatus, errorIndex, varBinds) in nextCmd(SnmpEngine(),
                                CommunityData(comm),
                                UdpTransportTarget((options.target, 161)),
                                ContextData(),
                                ObjectType(ObjectIdentity(options.gettable)),
                                lexicographicMode=False):

        if errorIndication:
            print(errorIndication)
            break
        elif errorStatus:
            print('%s at %s' % (errorStatus.prettyPrint(),
                                errorIndex and varBinds[int(errorIndex)-1][0] or '?'))
            break
        else:
            for varBind in varBinds:
                oid, value = varBind
                rest, cl = oid.prettyPrint().split('::', 1)
                c, l = cl.split('.', 1)

                if not (c in collumns):
                    collumns.append(c)

                if not (l in lines):
                    lines.append(l)

                values.append(value.prettyPrint())

    TablePrint(lines, collumns, values)

def TablePrint(lines, collumns, values):
    str = '\t'
    for i in range(len(collumns)):
        str = str + '|' + collumns[i] + '|' + '\t'
    str = str + '\n'

    for i in range(len(lines)):
        str = str + lines[i] + '\t'
        for c in range(len(collumns)):
            str = str + '|' + values[i + (len(lines) * c)] + '|' + '\t'
        str = str + '\n'

    print(str)
