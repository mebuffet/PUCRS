from pysnmp.hlapi import *

#Habilitar snmp: https://blog.paessler.com/how-to-enable-snmp-on-your-operating-system

#Este exemplo se encontram em: http://pysnmp.sourceforge.net/examples/hlapi/asyncore/sync/manager/cmdgen/snmp-versions.html
#Necessário: {python3,pip,pip install pysnmp}
#Exemplos bash:
#snmpget -v2c -c public demo.snmplabs.com SNMPv2-MIB::sysDescr.0 = SNMPv2-MIB::sysDescr.0 = STRING: SunOS zeus.snmplabs.com
#Ou
#snmpget -v2c -c public demo.snmplabs.com 1.3.6.1.2.1.1.1.0 = SNMPv2-MIB::sysDescr.0 = STRING: SunOS zeus.snmplabs.com

#Ambos os comandos ObjectIdentity são os mesmos, mudei apenas a representação.

errorIndication, errorStatus, errorIndex, varBinds = next(
    getCmd(SnmpEngine(),
           CommunityData('public'),
           UdpTransportTarget(('localhost', 161)),
           ContextData(),
           ObjectType(ObjectIdentity('1.3.6.1.2.1.1.1.0')),
           ObjectType(ObjectIdentity('SNMPv2-MIB', 'sysDescr', 0)))
)

if errorIndication:
    print(errorIndication)
elif errorStatus:
    print('%s at %s' % (errorStatus.prettyPrint(),
                        errorIndex and varBinds[int(errorIndex) - 1][0] or '?'))
else:
    for varBind in varBinds:
        print(' = '.join([x.prettyPrint() for x in varBind]))
