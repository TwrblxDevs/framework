@echo off
setlocal enabledelayedexpansion
FOR /F "tokens=*" %%i IN ('git rev-parse --abbrev-ref HEAD') DO SET branch=%%i
echo return { branchName = "!branch!" } > src\shared\.special\branch.lua
endlocal
