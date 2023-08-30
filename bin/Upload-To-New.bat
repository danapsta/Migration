@echo off

echo .
echo .
echo "Welcome to the Server Upload/Import Script"
echo "This script will re-install everything in the file tree from the old server"
echo "If you haven't ran the Export/Download Script, please do that first"
echo "Use at your own risk"
echo .
echo .

echo .
echo "Beginning Import"
echo .

echo "Installing Roles and Features"
REM Roles and Features
copy %CD%\Roles\InstallCommands %CD%\Roles\InstallCommands.ps1
powershell -executionpolicy unrestricted -File "%CD%\Roles\InstallCommands.ps1"
TIMEOUT 30

REM Printers
echo "Importing Printers"
powershell -Command "C:\windows\system32\spool\tools\printbrm -R -S \\%COMPUTERNAME% -F %CD%\Printers\Printers"
TIMEOUT 60

REM DHCP
echo "Importing DHCP"
powershell -Command "netsh dhcp server import %CD%\DHCP\DHCP.txt all -Verb RunAs"
TIMEOUT 60

echo .
echo "File Share Import still under development.  Please Import File Shares manually for now."
echo .
PAUSE
REM File Shares
REM net share >> %CD%\Fileshare\Shares.txt
REM reg export HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Shares "%CD%\Fileshare\Shares_key.reg"
REM TIMEOUT 10



