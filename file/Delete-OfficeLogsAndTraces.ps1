param (
    [Parameter(Mandatory=$false)]
    [int]$days = 0
)
# Description: Delete Office logs and traces
# Author: 0x6d69636b
# Usage: Delete-OfficeLogsAndTraces.ps1 -days 1

$limit = (Get-Date).AddDays(-$days)


# Delete Office logs and traces from %TEMP%\Diagnostics
$path = "$env:TEMP\Diagnostics"
Write-Host "Deleting Office logs and traces from $path"

$folders = Get-ChildItem "$path" -Directory -Name | Where-Object { $_ -in "OUTLOOK", "EXCEL", "WINWORD", "POWERPNT", "ONENOTE", "ACCESS" }

foreach ($folder in $folders) {
    $fullPath = Join-Path "$path" $folder
    Write-Host "Deleting files older than $days days in $fullPath :"
    Get-ChildItem -Path $fullPath -Recurse | Where-Object { $_.LastAccessTime -lt $limit } | Select-Object -Property FullName, LastAccessTime
    Get-ChildItem -Path $fullPath -Recurse | Where-Object { $_.LastAccessTime -lt $limit } | Remove-Item -Force
}

$fullPath = "$env:TEMP\Outlook Logging"
#check if folder exists
if ((Test-Path $fullPath)) {
    # Delete outlook logs and traces from %TEMP%\Outlook Logging
    Write-Host "Deleting files older than $days days in $fullPath :"
    Get-ChildItem -Path $fullPath -Recurse | Where-Object { $_.LastAccessTime -lt $limit } | Select-Object -Property FullName, LastAccessTime
    Get-ChildItem -Path $fullPath -Recurse | Where-Object { $_.LastAccessTime -lt $limit } | Remove-Item -Force
}

