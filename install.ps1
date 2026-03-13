# god bless this installer 
$installDir = Join-Path $env:LOCALAPPDATA "cdg"
$exePath = Join-Path $installDir "cdg.exe"

# install path check
if (!(Test-Path $installDir)) {
    New-Item -ItemType Directory -Path $installDir | Out-Null
}
Invoke-WebRequest "https://github.com/Gorgoll/cdg/releases/latest/download/cdg-windows-x64.exe" -OutFile $exePath

$functionName = "cdg"


$functionCode = @"
function cdg {
    `$dir = (& "$env:LOCALAPPDATA\cdg\cdg.exe").Trim()
    if (`$dir) { Set-Location `$dir }
}
"@
# if profile exist append if not create new one or somthing like that i hate powershell :>
if (!(Test-Path $PROFILE)) {
    New-Item -ItemType File -Path $PROFILE -Force | Out-Null
}
if (!(Select-String -Path $PROFILE -Pattern "function $functionName" -Quiet)) {
    Add-Content -Path $PROFILE -Value $functionCode
}
Write-Host "cdg installed."
