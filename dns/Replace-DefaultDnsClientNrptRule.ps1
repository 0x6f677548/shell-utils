#Add-DefaultDnsNrptRule
#Adds a NRPT rule with namespace '.' that points to provided $nameserver1 and $nameserver2
#useful to prevent dns leakage on windows, namely with smart multi-homed name resolution (SMHNR) 
#effects of SMHNR: https://www.sans.org/white-papers/40165/
#Steps:
# 1) Removes all NRPT rules with . namespace
# 2) Adds a NRPT rule with . namespace pointing to $nameserver1 and $nameserver2
#examples 
# .\Add-DefaultDnsClientNrptRule -nameserver1 '10.66.66.1' -nameserver2 'fd42:42:42::1'
# .\Add-DefaultDnsClientNrptRule -nameserver1 '1.1.1.1' -nameserver2 '2606:4700:4700::1111'
# .\Add-DefaultDnsClientNrptRule -nameserver1 '1.1.1.1' -nameserver2 '1.0.0.1'
param ($nameserver1, $nameserver2)


#calls Add-DnsClientNrptRule with . namespace and provided $nameserver1 and $nameserver2
.\Replace-DnsClientNrptRule -namespace '.' -displayname 'default' -nameserver1 $nameserver1 -nameserver2 $nameserver2
