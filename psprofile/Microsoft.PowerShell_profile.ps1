# Load scripts; dotsource everything from psfunctions directory
$functionsFolder = "$env:USERPROFILE\dev\dotfiles\psfunctions"
Get-ChildItem $functionsFolder | ForEach-Object {."$functionsFolder\$_"}

Write-Host "$(U 0x1F680) Your shell is loaded! $(U 0x1F680)" -ForegroundColor Green
Write-Host "For a list of custom commands, run 'Get-CustomFunctions'" -ForegroundColor Blue

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
