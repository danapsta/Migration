# Gets all network adapter configurations and lists each adapter with IP address, Subnet, DNS Configuration, and if it is set to DHCP. 

# Get All network adapters that are up
$Networks = Get-WmiObject -Class Win32_NetworkAdapterConfiguration -Filter "IPEnabled = TRUE"

# Empty array to hold output
$Output = @()

# Define the path to the output file relative to the script's directory
$outputPath = Join-Path -Path $PSScriptRoot -ChildPath "..\Server_Information.txt"

foreach ($Network in $Networks) {
    # Get DHCP status for IP and DNS
    $DhcpEnabled = $Network.DHCPEnabled -eq $true
    $DnsObtainedFromDhcp = $Network.DNSServerSearchOrder -eq $null -or $Network.FullDNSRegistrationEnabled -eq $true

    # Get IP, subnet, gateway and DNS info
    $IPAddress  = $Network.IPAddress[0]
    $SubnetMask = $Network.IPSubnet[0]
    $DefaultGateway = $Network.DefaultIPGateway -join ', '
    $DNSServers = $Network.DNSServerSearchOrder -join ', '

    # Build custom PSObject
    $Output += New-Object -TypeName PSObject -Property @{
        AdapterName          = $Network.Description
        IPAddress            = $IPAddress
        SubnetMask           = $SubnetMask
        DefaultGateway       = $DefaultGateway
        DNSServers           = $DNSServers
        DhcpEnabled          = if($DhcpEnabled) {'Yes'} else {'No'}
        DnsObtainedFromDhcp  = if($DnsObtainedFromDhcp) {'Yes'} else {'No'}
    }
}

# Print the output
$NewLines = "`n`n`n`n`n`n`n`n`n`n"
$NewLines >> $outputPath
$Output | Format-Table -AutoSize >> $outputPath