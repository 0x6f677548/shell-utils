# ps-utils
Some useful powershell scripts for daily tasks
## Script List
### Get-DnsOrder
Lists client device dns configured addresses on connected devices, by interface metric order. Example

```
$ .\Get-DnsOrder.ps1


InterfaceAlias              InterfaceIndex InterfaceMetric DNSIPv4            DNSIPv6
--------------              -------------- --------------- -------            -------
wireguard-pihole                        54               5 {10.66.66.1}       {fd42:42:42::1}
Wi-Fi                                    6              30 {1.1.1.1, 1.0.0.1} {}
Loopback Pseudo-Interface 1              1              75 {}                 {fec0:0:0:ffff::1, fec0:0:0:ffff::2, fec0:0:0:ffff::3}
```

### Set-CloudFlareDns
Sets the client dns of the $interface provided to Cloudflare dns

```
$ .\Set-CloudFlareDns.ps1 -interface 6
```
