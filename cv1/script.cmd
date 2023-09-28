@echo off
if not exist stats.txt echo 0 0 0 > stats.txt

REM Using a loop in the script, replace % with %% 
for /f "tokens=1,2,3" %%i in (stats.txt) do (
    set total=%%i
    set errors=%%j
    set errorsInRow=%%k
)

set "test_ip=1.1.2.5"
set "threshold=2"

ping -n 1 %test_ip% > nul

if errorlevel 1 (
    set RESULT=Fail
    set /a errors+=1
    set /a errorsInRow+=1
) else (
    set RESULT=OK
    set errorsInRow=0
)

set /a total+=1
echo %date%;%time%;%RESULT% >> log.txt
echo %total% %errors% %errorsInRow% > stats.txt

REM Registry update - HKCU (registry current user), /v value_name, /t data_type - REG_SZ = string, /d data, /f force update 
reg add HKCU\cviko /v name /t REG_SZ /d sample_data /f

REM Query this registry entry - (where to look, what to look for)
reg query HKCU\cviko /v name
