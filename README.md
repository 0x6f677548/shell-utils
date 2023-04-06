# shell-utils
Some shell utilities for daily tasks, namely around DNS, Wifi, OneDrive, and file management
Writen for Powershell and Bash


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

### Networking - General

#### Get-ActiveConnections
Lists Active TCP Connections, including their PIDs and the process name. Useful to identify which process is using a specific port and to where it is connecting to. Tries to identity the owner of the IP address, country, by using ipinfo.io service.

Example
```
$ .\Get-ActiveConnections.ps1

Process Name: SearchHost (PID: 10120)
Connections:
  0.0.0.0:51143 -> 0.0.0.0:0 (Dest IP: 0.0.0.0)
    Public IP Info:  ()
  0.0.0.0:51133 -> 0.0.0.0:0 (Dest IP: 0.0.0.0)
    Public IP Info:  ()
  192.168.1.195:51143 -> 23.47.188.105:443 (Dest IP: 23.47.188.105)
    Public IP Info: Akamai International B.V. (Portugal) (Hostname: a23-47-188-105.deploy.static.akamaitechnologies.com)
Process Name: SurfaceAppDt (PID: 11468)
Connections:
  0.0.0.0:51962 -> 0.0.0.0:0 (Dest IP: 0.0.0.0)
    Public IP Info:  ()
Process Name: pwsh (PID: 11504)
Connections:
  :::52013 -> :::0 (Dest IP: ::)
  192.168.1.195:52013 -> 52.236.186.216:443 (Dest IP: 52.236.186.216)
    Public IP Info: Microsoft Corporation (Netherlands)
```


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


#### Replace-DefaultDnsNrptRule
Adds a NRPT rule with namespace '.' that points to provided $nameserver1 and $nameserver2. Useful to prevent dns leakage on Windows, namely with smart multi-homed name resolution (SMHNR). 
For detailed effects of SMHNR on privacy, refer to https://www.sans.org/white-papers/40165/

Steps:
    1) Removes all NRPT rules with . namespace
    2) Adds a NRPT rule with . namespace pointing to $nameserver1 and $nameserver2

Example

``` 
# setting DNS to the ipv4 and ipv6 of a split tunnel (like wireguard)
.\Replace-DefaultDnsClientNrptRule -nameserver1 '10.66.66.1' -nameserver2 'fd42:42:42::1'


# setting DNS to the ipv4 and ipv6 addresses of CloudFlare
.\Replace-DefaultDnsClientNrptRule -nameserver1 '1.1.1.1' -nameserver2 '2606:4700:4700::1111'

# setting DNS to the ipv4 addresses of CloudFlare
.\Replace-DefaultDnsClientNrptRule -nameserver1 '1.1.1.1' -nameserver2 '1.0.0.1'
```

### Wifi related scripts
### Get-WifiProfiles
Dumps all wifi profiles, including their passwords

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

