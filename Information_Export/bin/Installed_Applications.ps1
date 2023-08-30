# Get all installed applications from the registry
$installedApps = Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | 
    Select-Object DisplayName, DisplayVersion, Publisher, InstallDate

# Define the path to the output file relative to the script's directory
$outputPath = Join-Path -Path $PSScriptRoot -ChildPath "..\Server_Information.txt"

# Output the installed applications
$NewLines = "`n`n`n`n`n`n`n`n`n`n"
$NewLines >> $outputPath
$installedApps | Format-Table -AutoSize >> $outputPath

# Get all services with their state and startup configuration
$services = Get-WmiObject -Class Win32_Service | 
    Select-Object Name, DisplayName, State, StartMode

# Output the services
$NewLines = "`n`n`n`n`n`n`n`n`n`n"
$NewLines >> $outputPath
$services | Format-Table -AutoSize >> $outputPath
 