@echo off
echo "hi"
setlocal enabledelayedexpansion
FOR /F "tokens=*" %%i IN ('git rev-parse --abbrev-ref HEAD') DO SET branch=%%i
echo "got !branch!"
echo return { branchName = "!branch!" } > ..\src\shared\.special\branch.luau
endlocal
