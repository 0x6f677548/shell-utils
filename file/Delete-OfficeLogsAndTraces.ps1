# Description: Delete Office logs and traces
# Author: 0x6d69636b


# Delete Office logs and traces from %TEMP%\Diagnostics
$path = "$env:TEMP\Diagnostics"

$folders = Get-ChildItem "$path" -Directory -Name | Where-Object { $_ -in "OUTLOOK", "EXCEL", "WINWORD", "POWERPNT", "ONENOTE", "ACCESS" }

foreach ($folder in $folders) {
    $fullPath = Join-Path "$path" $folder
    Remove-Item $fullPath -Recurse -Force
}

$path = "$env:TEMP\Outlook Logging"
#check if folder exists
if ((Test-Path $path)) {
    # Delete outlook logs and traces from %TEMP%\Outlook Logging
    Remove-Item $path -Recurse -Force
}

