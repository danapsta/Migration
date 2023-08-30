echo "Setting Current Directory Location"
$CD = get-location

echo "Listing Installed Features"
Get-Windowsfeature | where-object {$_.InstallState -eq 'Installed'} | select-object Name > $CD\Roles\Features

echo "Searching for DHCP Service"
$search = get-content $CD\Roles\Features | Select-String -Pattern 'DHCP'
if ($search){'Install-WindowsFeature -Name DHCP -IncludeManagementTools' > $CD\Roles\InstallCommands} else {echo "DHCP Not Installed"}

echo "Searching for DNS Service"
$search = get-content $CD\Roles\Features | Select-String -Pattern 'DNS'
if ($search){'Install-WindowsFeature -Name DNS -IncludeManagementTools' >> $CD\Roles\InstallCommands} else {echo "DNS Not Installed"}

echo "Searching for Powershell Service"
$search = get-content $CD\Roles\Features | Select-String -Pattern 'Powershell'
if ($search){'Install-WindowsFeature -Name Powershell -IncludeManagementTools' >> $CD\Roles\InstallCommands} else {echo "Powershell not Installed"}

echo "Searching for Domain Services"
$search = get-content $CD\Roles\Features | Select-String -pattern 'AD-Domain-Services'
if ($search){'Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools' >> $CD\Roles\InstallCommands} else {echo "ADDS not Installed"}

echo "Searching for Print Services"
$search = get-content $CD\Roles\Features | Select-String -Pattern 'Print-Services'
if ($search){'Install-WindowsFeature -Name Print-Services -Includemanagementtools' >> $CD\Roles\InstallCommands} else {echo "Print Services not Installed"}

echo "Searching for Print Server"
$search = get-content $CD\Roles\Features | Select-String -Pattern 'Print-Server'
if ($search){'Install-WindowsFeature -Name Print-Server -Includemanagementtools' >> $CD\Roles\InstallCommands} else {echo "Print Server not Installed"}

echo "Searching for File Services"
$search = get-content $CD\Roles\Features | Select-String -Pattern 'File-Services'
if ($search){'Install-WindowsFeature -Name File-Services -Includemanagementtools' >> $CD\Roles\InstallCommands} else {echo "File-Services not Installed"}

echo "Searching for File Server"
$search = get-content $CD\Roles\Features | Select-String -Pattern 'FS-FileServer'
if ($search){'Install-WindowsFeature -Name FS-FileServer -Includemanagementtools' >> $CD\Roles\InstallCommands} else {echo "File Server not Installed"}

# powershell -Command "Get-Windowsfeature | where-object {$_.InstallState -eq 'Installed | select-object Name > Features"
# copy C:\Users\%USERNAME%\Features %CD%\Roles\Featuers
# del C:\Users\%USERNAME%\Features
# powershell -Command "$CD = get-location"
# powershell -Command "$search = get-content $CD\Roles\Features | Select-String -Pattern 'DHCP'
# powershell -Command "if ($search){"Install-WindowsFeature -Name DHCP -ComputerName $COMPUTERNAME -IncludeManagementTools" > $CD\Roles\InstallCommands} else {echo "No DHCP Installed"}
PAUSE