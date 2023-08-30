# Get all PowerShell scripts in the current directory
$scripts = Get-ChildItem -Path $PSScriptRoot -Filter "*.ps1"

# Run each script
foreach ($script in $scripts) {
    # Skip the script itself
    if ($script.FullName -eq $PSCommandPath) { continue }

    Write-Host "Running script: $($script.FullName)"
    Invoke-Expression -Command:$script.FullName
    Write-Host "Finished running script: $($script.FullName)"
}
