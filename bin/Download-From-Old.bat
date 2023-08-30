@echo off

echo .
echo .
echo "Welcome to the Server Download/Export Script"
echo "This script will collect the most relevant information from an existing server and prepare new script for upload"
echo "Use at your own risk"
echo .
echo .

echo .
echo "Beginning Export"
echo .

echo . 
echo "Exporting General System Information"
echo "File Server_Information.txt in Migration\Information_Export folder"
echo .

powershell -executionpolicy unrestricted -File "%CD%\Information_Export\bin\EXPORT.ps1"

echo "Exporting Printers"
powershell -Command "C:\windows\system32\spool\tools\printbrm -B -S \\%COMPUTERNAME% -F %CD%\Printers\Printers" 
TIMEOUT 10

REM DHCP
echo Exporting DHCP
powershell -Command "netsh dhcp server export %CD%\DHCP\DHCP.txt all"
TIMEOUT 10

REM File Shares
net share >> %CD%\Fileshare\Shares.txt
reg export HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Shares "%CD%\Fileshare\Shares_key.reg"
TIMEOUT 10

REM Roles and Features
powershell -executionpolicy unrestricted -File "%CD%\bin\Role_Import.ps1"
PAUSE

