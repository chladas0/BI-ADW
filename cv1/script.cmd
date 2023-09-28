echo off
if not exist stats.txt echo 0 0 0 > stats.txt

REM if we use cycle in script % -> %% 
for /f "tokens=1,2,3" %%i in (stats.txt) do (
    set celkem=%%i
    set chyb=%%j
    set chybvrade=%%k
)

set "test_ip=1.1.2.5"
set "threshhold=2"

ping -n 1 %test_ip% > nul

if errorlevel 1 (
    set RESULT=Fail
    set /a chyb+=1
    set /a chybvrade+=1
) else (
    set RESULT=OK
    set chybvrade=0
)

set /a celkem+=1
echo %date%;%time%;%RESULT% >> log.txt
echo %celkem% %chyb% %chybvrade% > stats.txt

REM HKCU - kam(registry current usera), /v pojmenovani dat co ukladame, /t datatype - REG_SZ = string, /d samotna data, /f force update 
reg add HKCU\cviko /v nazev /t REG_SZ /d tohlejsoudata /f
REM dotaz na tento register parametry - (kde hledam, co hledam)
reg query HKCU\cviko /v nazev

if %chybvrade% EQU %threshhold% echo "Hodne chyb, styd se"