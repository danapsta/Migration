@echo off
echo cd %CD% > %CD%\bin\append
type %CD%\bin\Download-From-Old.bat >> %CD%\bin\append
del %CD%\bin\Download-From-Old.bat 
ren %CD%\bin\append Download-From-Old.bat
powershell -Command "Start-Process %CD%\bin\Download-From-Old.bat -Verb RunAs"
