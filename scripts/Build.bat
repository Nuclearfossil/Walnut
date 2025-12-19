@echo off
setlocal

set "vswhere=%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe"
if not exist "%vswhere%" (
    echo vswhere.exe not found. Is Visual Studio installed?
    exit /b 1
)

for /f "usebackq tokens=*" %%i in (`"%vswhere%" -latest -requires Microsoft.Component.MSBuild -find MSBuild\**\Bin\MSBuild.exe`) do (
    set "MSBuildPath=%%i"
)

if "%MSBuildPath%"=="" (
    echo MSBuild.exe not found.
    exit /b 1
)

echo Using MSBuild at: "%MSBuildPath%"

"%MSBuildPath%" "%~dp0..\WalnutApp.sln" -p:Configuration=Debug -p:Platform=x64 -p:VcpkgEnabled=false
if %ERRORLEVEL% NEQ 0 (
    echo Build failed with exit code %ERRORLEVEL%
    exit /b %ERRORLEVEL%
)

echo Build succeeded!
