# Description: Delete files older than 7 days in the temp folder
# author: 0x6d69636b

$limit = (Get-Date).AddDays(-7)
$path = "$env:TEMP"

Get-ChildItem -Path $path -Recurse | Where-Object { $_.LastAccessTime -lt $limit } | Remove-Item -Force
