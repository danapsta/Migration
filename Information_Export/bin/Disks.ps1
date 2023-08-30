# Get all system drives
$drives = Get-PSDrive -PSProvider FileSystem

# Define the path to the output file relative to the script's directory
$outputPath = Join-Path -Path $PSScriptRoot -ChildPath "..\Server_Information.txt"

# Output the results
$NewLines = "`n`n`n`n`n`n`n`n`n`n"
$NewLines >> $outputPath

$drives | ForEach-Object {
    $volume = Get-Volume -DriveLetter $_.Name

    New-Object -TypeName PSObject -Property @{
        Name = $_.Name
        'Used(GB)' = "{0:N2}" -f ($_.Used / 1GB)
        'Free(GB)' = "{0:N2}" -f ($_.Free / 1GB)
        'TotalSize(GB)' = "{0:N2}" -f ($volume.Size / 1GB)
        Provider = $_.Provider
    }
} | Format-Table -AutoSize >> $outputPath