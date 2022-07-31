# shell-utils
Some useful shell scripts for daily tasks
## Linux
### DNS Related
### dnsflood.sh
Generates flood requests using dnsperf util (https://github.com/DNS-OARC/dnsperf) . It targets  a destination dns server, with random requests from files in ./dnsflood-rndrecs/ folder. Useful to flood a dns server, testing performance, or mining pi-holes with random data

Usage:
```
# 60 minutes, targetting 192.168.1.1
./dhsflood.sh 60 192.168.1.1
```

## PowerShell 
### DNS Related scripts
#### Get-DnsOrder
Lists client device dns configured addresses on connected devices, by interface metric order. 
Example
```
$ .\Get-DnsOrder.ps1


InterfaceAlias              InterfaceIndex InterfaceMetric DNSIPv4            DNSIPv6
--------------              -------------- --------------- -------            -------
wireguard-pihole                        54               5 {10.66.66.1}       {fd42:42:42::1}
Wi-Fi                                    6              30 {1.1.1.1, 1.0.0.1} {}
Loopback Pseudo-Interface 1              1              75 {}                 {fec0:0:0:ffff::1, fec0:0:0:ffff::2, fec0:0:0:ffff::3}
```

#### Set-CloudFlareDns
Sets the client dns of the $interface provided to Cloudflare dns

Example
```
$ .\Set-CloudFlareDns.ps1 -interface 6
```


#### Set-LocalhostDns
Sets the client dns of the $interface provided to localhost address. Useful when using dns-proxy.
It can also be a workaround to prevent dns leakage on windows on multi-homed devices, like when using a DNS split tunnel, although the best approach is to use NRPT tables (refer to https://www.sans.org/white-papers/40165/)  


Example
```
# .\Set-LocalhostDns.ps1 -interface 6
```


#### Add-DefaultDnsNrptRule
Adds a NRPT rule with namespace '.' that points to provided $nameserver1 and $nameserver2. Useful to prevent dns leakage on Windows, namely with smart multi-homed name resolution (SMHNR). 
For detailed effects of SMHNR on privacy, refer to https://www.sans.org/white-papers/40165/

Steps:
    1) Removes all NRPT rules with . namespace
    2) Adds a NRPT rule with . namespace pointing to $nameserver1 and $nameserver2

Example

``` 
# setting DNS to the ipv4 and ipv6 of a split tunnel (like wireguard)
.\Add-DefaultDnsClientNrptRule -nameserver1 '10.66.66.1' -nameserver2 'fd42:42:42::1'


# setting DNS to the ipv4 and ipv6 addresses of CloudFlare
.\Add-DefaultDnsClientNrptRule -nameserver1 '1.1.1.1' -nameserver2 '2606:4700:4700::1111'

# setting DNS to the ipv4 addresses of CloudFlare
.\Add-DefaultDnsClientNrptRule -nameserver1 '1.1.1.1' -nameserver2 '1.0.0.1'
```


### File related scripts
#### Move-PartialFolder
Moves the top $numberOfFolders of child directories of $source to $destination. 
This is usefull when moving large folders and to be used inside scheduled tasks or onedrive migrations
Example
```
$ .\Move-PartialFolder -source 'c:\temp' -destination 'c:\temp2' -numberOfFolders 2
```

### OneDrive related scripts
#### Get-OneDriveDeprovisioningQueue
Lists files inside $directory being depromoted to online only inside a loop. Waits $wait millisencods

#### Get-OneDriveSyncingQueu
Lists files inside $directory being synched. Waits $wait millisencods

#### Move-PartialFolderToOneDrive
Moves the $numberOfFolders of child directories of $source to $destination, assuming that Destination is a Onedrive folder
It waits that each directory syncs, before moving to the next one 
This is usefull when moving large folders and to be used inside scheduled tasks or onedrive migrations

#### Set-OneDriveOnlineOnly
Sets all files in $directory to online-only

#### Touch-OneDriveSyncingFiles
Touches a syncing file inside $directory. Sometimes this is usefull to unblock syncing files. 

