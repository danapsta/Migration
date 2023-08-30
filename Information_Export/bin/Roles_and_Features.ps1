# Lists all installed roles and features on the target server

# Load Server Manager Module
Import-module ServerManager

# Get all installed roles and features
$features = get-windowsfeature | where-object {$_.Installed -eq $True}

# Define the path to the output file relative to the script's directory
$outputPath = Join-Path -Path $PSScriptRoot -ChildPath "..\Server_Information.txt"

# Append installed roles and features to the text file
$NewLines = "`n`n`n`n`n`n`n`n`n`n"
$NewLines >> $outputPath
$features | Format-Table -Property DisplayName, Name >> $outputPath
