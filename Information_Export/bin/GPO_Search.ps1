# Script to parse all GPOs and list all which have a UNC path applied.  Will also list all printer and drive map GPOs with all drives and printers applied. 

# Define the path to the output file relative to the script's directory
$outputPath = Join-Path -Path $PSScriptRoot -ChildPath "..\Server_Information.txt"

# Load Group Policy module
Import-Module GroupPolicy

# Get all GPOs in the domain
$allGPOs = Get-GPO -All

# Prepare the regular expression for UNC path
$regex = '\\\\[^\\]+\\[^\\]+'

# Create an array to hold results
$results = @()

# Iterate over each GPO
foreach ($gpo in $allGPOs) {
    # Get the XML content of the GPO
    $gpoXml = Get-GPOReport -Guid $gpo.Id -ReportType xml

    # Check for drive mappings and printer connections
    if ($gpoXml -match 'Drive Map' -or $gpoXml -match 'Printers Connections') {
        # If found, search for UNC paths
        $matchResult = [regex]::matches($gpoXml, $regex)

        # If found, add to results
        if ($matchResult) {
            $uncPaths = $matchResult | ForEach-Object { $_.Value } | Sort-Object -Unique

            foreach ($uncPath in $uncPaths) {
                $results += New-Object PSObject -Property @{
                    GpoName = $gpo.DisplayName
                    UncPath = $uncPath
                }
            }
        }
    }
}

# Output the results
$NewLines = "`n`n`n`n`n`n`n`n`n`n"
$NewLines >> $outputPath
$results | Format-List >> $outputPath