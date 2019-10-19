from pysnmp.hlapi import *

def Walk(options):
    if (options.public):
        comm = 'public'
    elif not (options.community == None):
        comm = options.community

    lstOIDs = ParseOIDs(options.walk)

    last = ''
    for oid in lstOIDs:
        for (errorIndication, errorStatus, errorIndex, varBinds) in nextCmd(SnmpEngine(),
                                    CommunityData(comm),
                                    UdpTransportTarget((options.target, 161)),
                                    ContextData(),
                                    ObjectType(ObjectIdentity(oid))):

              if errorIndication:
                  print(errorIndication)
                  break
              elif errorStatus:
                  print('%s at %s' % (errorStatus.prettyPrint(),
                                      errorIndex and varBinds[int(errorIndex) - 1][0] or '?'))
                  break
              else:
                  for varBind in varBinds:
                      oid, value = varBind
                      rest, cl = oid.prettyPrint().split('::', 1)
                      if not(last == rest) and not (last == ''):
                          break
                      last = rest
                      print(' = '.join([x.prettyPrint() for x in varBind]))
              if not(last == rest) and not (last == ''):
                  break

def ParseOIDs(str):
    if not (str.find('[') == -1):
        str = str.replace('[','')
        str = str.replace(']','')
        lst = str.split(',')
        return lst
    else:
        return [str]
