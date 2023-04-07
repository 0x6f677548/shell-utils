param(
    [Parameter(Mandatory=$false)]
    [int]$days = 7
)
# Description: Delete files older than $days days in the temp folder
# author: 0x6d69636b
# usage: Delete-OldTempFiles.ps1 -days 7

$limit = (Get-Date).AddDays(-$days)
$path = "$env:TEMP"


Write-Host "Deleting files older than $days days in $path :"
Get-ChildItem -Path $path -Recurse | Where-Object { $_.LastAccessTime -lt $limit } | Select-Object -Property FullName, LastAccessTime
Get-ChildItem -Path $path -Recurse | Where-Object { $_.LastAccessTime -lt $limit } | Remove-Item -Force
