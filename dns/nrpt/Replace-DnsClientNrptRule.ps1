#Add-DnsNrptRule
#Adds a NRPT rule with namespace $namespace that points to provided $nameserver1 and $nameserver2
#Steps:
# 1) Removes all NRPT rules with $namespace namespace
# 2) Adds a NRPT rule with $namespace pointing to $nameserver1 and $nameserver2
#examples 
# .\Replace-DnsClientNrptRule -namespace '.' -displayname 'default' -nameserver1 '10.66.66.1' -nameserver2 'fd42:42:42::1'
# .\Replace-DnsClientNrptRule  -namespace '.' -displayname 'default' -nameserver1 '1.1.1.1' -nameserver2 '2606:4700:4700::1111'
# .\Replace-DnsClientNrptRule  -namespace '.' -displayname 'default' -nameserver1 '1.1.1.1' -nameserver2 '1.0.0.1'
param ($namespace, $displayname, $nameserver1, $nameserver2)



function Test-Param($param, $paramname) {
    if ($null -eq $param) {
        write-host "Missing parameter $paramname"
        exit
    }
}

#test if all parameters are provided
Test-Param $namespace -paramname 'namespace'
Test-Param $displayname -paramname 'displayname'
Test-Param $nameserver1 -paramname 'nameserver1'
Test-Param $nameserver2 -paramname 'nameserver2'



$DNSAddresses = @(
  ([IPAddress]$nameserver1).IPAddressToString
  ([IPAddress]$nameserver2).IPAddressToString
)

#prints all NRPT rules with $namespace namespace
Write-Host ("Rules to be deleted:")
Get-DnsClientNRptRule | Where-Object {$_.Namespace -eq $namespace }  | Format-Table displayName, nameSpace, nameServers


#clears all rules from the NRPT with the same namespace
Get-DnsClientNRptRule | Where-Object {$_.Namespace -eq $namespace} | Remove-DnsClientNrptRule -Force

Add-DnsClientNrptRule -Namespace $namespace -DisplayName $displayname -NameServers $DNSAddresses

Write-Host ("New rule created:")
Get-DnsClientNRptRule | Where-Object {$_.Namespace -eq $namespace}  | Format-Table displayName, nameSpace, nameServers
