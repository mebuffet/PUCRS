from pysnmp.hlapi import *

def Set(options):
    if (options.public):
        comm = 'public'
    elif not (options.community == None):
        comm = options.community

    errorIndication, errorStatus, errorIndex, varBinds = next(
          setCmd(SnmpEngine(),
                 CommunityData(comm),
                 UdpTransportTarget((options.target, 161)),
                 ContextData(),
                 ObjectType(ObjectIdentity(options.set), options.vset))
    )

    if errorIndication:
          print(errorIndication)
    elif errorStatus:
          print('%s at %s' % (errorStatus.prettyPrint(),
                              errorIndex and varBinds[int(errorIndex) - 1][0] or '?'))
    else:
          for varBind in varBinds:
              print(' = '.join([x.prettyPrint() for x in varBind]))
