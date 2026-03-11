if(!(Test-Path "C:/Windows/Cdg")){
    mkdir "C:/Windows/Cdg"
}
if(!(Test-Path "$env:USERPROFILE/.local/cdg")){
    mkdir "$env:USERPROFILE/.local/cdg"
}
$file = @{
    destination = "$env:USERPROFILE\.local\cdg\cdg.exe"
}
Invoke-WebRequest "https://github.com/Gorgoll/cdg/releases/latest/download/cdg-Linux-x64" -OutFile $file.destination


$functionName = "cdg"

$functionCode = @"
$cdg = function cdg {
    $dir = (& "C:/$env:USERPROFILE/.local/cdg/cdg.exe").Trim()
    Write-Host "$dir"
    Set-Location $dir
}
"@

if(Test-Path $PROFILE){
    if(!(Select-String -Path $PROFILE -Pattern "function $functionName" -Quiet)){
        Add-Content -Path $PROFILE -Value $functionCode
    }
}
else{
    New-Item -ItemType File -Path $PROFILE -Force | Out-Null
    Add-Content -Path $PROFILE -Value $functionCode
}