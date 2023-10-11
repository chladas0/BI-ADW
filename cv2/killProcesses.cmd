setlocal enabledelayedexpansion

for /f "tokens=1" %%i in ('type toKill.txt') do (
    taskkill /im %%i /fi "username eq %USERNAME%" /f | find "SUCCESS" > nul
    if !errorlevel! equ 0 (
        echo %%i byl úspěšně ukončen.
    ) else (
        echo %%i nelze ukončit nebo není spuštěn.
    )
)
