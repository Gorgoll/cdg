# god bless this installer 
$installDir = Join-Path $env:LOCALAPPDATA "cdg"
$exePath = Join-Path $installDir "cdg.exe"

if (!(Test-Path $installDir)) {
    New-Item -ItemType Directory -Path $installDir | Out-Null
}
Invoke-WebRequest "https://github.com/Gorgoll/cdg/releases/latest/download/cdg-windows-x64.exe" -OutFile $exePath

$functionName = "cdg"

$functionCode = @"
function cdg {
    `$dir = (& "$env:LOCALAPPDATA\cdg\cdg.exe").Trim()
    Write-Host "`$dir"
    Set-Location `$dir
}
"@

if (!(Test-Path $PROFILE)) {
    New-Item -ItemType File -Path $PROFILE -Force | Out-Null
}
if (!(Select-String -Path $PROFILE -Pattern "function $functionName" -Quiet)) {
    Add-Content -Path $PROFILE -Value $functionCode
}
Write-Host "cdg installed."
