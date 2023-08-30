# Script to list all users with a startup script applied and the path to said script

# Define the path to the output file relative to the script's directory
$outputPath = Join-Path -Path $PSScriptRoot -ChildPath "..\Server_Information.txt"


# Import the Active Directory module
Import-Module ActiveDirectory

# Get all users in the domain that have a startup script configured
$usersWithStartupScripts = Get-ADUser -Filter * -Properties scriptPath | Where-Object { $_.scriptPath }

# Output the results
$NewLines = "`n`n`n`n`n`n`n`n`n`n"
$NewLines >> $outputPath
$usersWithStartupScripts | Format-Table -Property SamAccountName, scriptPath -AutoSize >> $outputPath