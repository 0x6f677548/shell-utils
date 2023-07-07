# shell-utils
Some shell utilities for daily tasks, namely around DNS, Wifi, OneDrive, and file management
Writen for Powershell and Bash


## DNS Related scripts
dnsflood, nrpt rules, dns order, etc. For more details, see [dns](/networking/dns/readme.md)



## Networking - General

### Get-ActiveConnections
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

### Wifi related scripts
#### Get-WifiProfiles
Dumps all wifi profiles, including their passwords

## File related scripts
### Move-PartialFolder
Moves the top $numberOfFolders of child directories of $source to $destination. 
This is usefull when moving large folders and to be used inside scheduled tasks or onedrive migrations
Example
```
$ .\Move-PartialFolder -source 'c:\temp' -destination 'c:\temp2' -numberOfFolders 2
```

## OneDrive related scripts
### Get-OneDriveDeprovisioningQueue
Lists files inside $directory being depromoted to online only inside a loop. Waits $wait millisencods

### Get-OneDriveSyncingQueu
Lists files inside $directory being synched. Waits $wait millisencods

### Move-PartialFolderToOneDrive
Moves the $numberOfFolders of child directories of $source to $destination, assuming that Destination is a Onedrive folder
It waits that each directory syncs, before moving to the next one 
This is usefull when moving large folders and to be used inside scheduled tasks or onedrive migrations

### Set-OneDriveOnlineOnly
Sets all files in $directory to online-only

### Touch-OneDriveSyncingFiles
Touches a syncing file inside $directory. Sometimes this is usefull to unblock syncing files. 

