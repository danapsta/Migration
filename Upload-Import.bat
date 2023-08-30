@echo off
echo cd %CD% > %CD%\bin\append
type %CD%\bin\Upload-To-New.bat >> %CD%\bin\append
del %CD%\bin\Upload-To-New.bat 
ren %CD%\bin\append Upload-To-New.bat
powershell -Command "Start-Process %CD%\bin\Upload-To-New.bat -Verb RunAs"
