# Description: This script creates a scheduled task to run the Delete-OldTempFiles.ps1 script on logon
# and the Delete-OfficeLogsAndTraces.ps1 script on logon.
# It downloads the two PowerShell scripts from the GitHub repository and creates the scheduled task.
# author: 0x6d69636b

$taskName = "Delete Temp files older than 7 days, DiagOutputDir older than 1 day, and Office logs and traces older than 1 day"
$githubRepoUrl = "https://raw.githubusercontent.com/0x6f677548/shell-utils/main/file"
$downloadPath = "$env:USERPROFILE"
$currentUserName = "$env:COMPUTERNAME\$env:USERNAME"


# Download scripts from GitHub
$urls = @("$githubRepoUrl/Delete-OfficeLogsAndTraces.ps1",
          "$githubRepoUrl/Delete-OldFiles.ps1")
foreach ($url in $urls) {
    $fileName = Split-Path -Leaf $url
    $filePath = Join-Path $downloadPath $fileName
    $result = Invoke-WebRequest -Uri $url -OutFile $filePath

    if ($result.StatusCode -ne 200) {
        Write-Host "Error downloading $fileName ... exiting"
        exit
    }

}


# Create the scheduled task to run the two PowerShell scripts on logon
$action1 = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-NoProfile -ExecutionPolicy Bypass -File `"$downloadPath\Downloads\Delete-OfficeLogsAndTraces.ps1`" -days 1"
$action2 = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-NoProfile -ExecutionPolicy Bypass -File `"$downloadPath\Downloads\Delete-OldFiles.ps1`" -days 7"
$action3 = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-NoProfile -ExecutionPolicy Bypass -File `"$downloadPath\Delete-OldFiles.ps1`" -path `"$env:TEMP\DiagOutputDir`" -days 1"
$trigger = New-ScheduledTaskTrigger -AtLogOn -User $currentUserName
$settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -StartWhenAvailable
Register-ScheduledTask -TaskName $taskName -Action $action1, $action2, $action3 -Trigger $trigger -Settings $settings
