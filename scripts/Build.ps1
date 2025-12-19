$ErrorActionPreference = "Stop"

# Find MSBuild
$vswhere = "${env:ProgramFiles(x86)}\Microsoft Visual Studio\Installer\vswhere.exe"
if (-not (Test-Path $vswhere)) {
    Write-Error "vswhere.exe not found. Is Visual Studio installed?"
}

$msbuildPath = & $vswhere -latest -requires Microsoft.Component.MSBuild -find MSBuild\**\Bin\MSBuild.exe
if (-not $msbuildPath) {
    Write-Error "MSBuild.exe not found."
}
$msbuildPath = $msbuildPath | Select-Object -First 1

Write-Host "Using MSBuild at: $msbuildPath"

# Build Solution
$sln = Join-Path $PSScriptRoot "..\WalnutApp.sln"
& $msbuildPath $sln -p:Configuration=Debug -p:Platform=x64 -p:VcpkgEnabled=false

if ($LASTEXITCODE -ne 0) {
    Write-Error "Build failed with exit code $LASTEXITCODE"
}
else {
    Write-Host "Build succeeded!" -ForegroundColor Green
}
