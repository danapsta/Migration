# 3. Script to list all users and home directory information (for only those with a home directory)

# Define the path to the output file relative to the script's directory
$outputPath = Join-Path -Path $PSScriptRoot -ChildPath "..\Server_Information.txt"

# Output
$NewLines = "`n`n`n`n`n`n`n`n`n`n"
$NewLines >> $outputPath
$users = get-aduser -filter * -properties homedirectory | select-object samaccountname,homedirectory;
foreach ($user in $users){if($user.homedirectory){get-aduser -identity $user.samaccountname -properties homedirectory | select-object samaccountname,homedirectory >> $outputPath}}
