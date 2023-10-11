@echo off

reg query HKCU\Software\ADW /v counter || reg add HKCU\Software\ADW /v counter /d 0
for /f "skip=1 tokens=3" %%i in ('reg query HKCU\Software\ADW /v counter') do set /a counter=%%i
set /a counter+=1
reg add HKCU\Software\ADW /v counter /d %counter% /f
