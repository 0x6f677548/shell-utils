# shell-utils
Some useful shell scripts for daily tasks
## PowerShell
### DNS Related
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

### Files related
#### Move-PartialFolder
Moves the top $numberOfFolders of child directories of $source to $destination. 
This is usefull when moving large folders and to be used inside scheduled tasks or onedrive migrations
Example
```
$ .\Move-PartialFolder -source 'c:\temp' -destination 'c:\temp2' -numberOfFolders 2
```

### OneDrive related
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

