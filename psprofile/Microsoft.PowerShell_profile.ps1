# Load scripts; dotsource everything from psfunctions directory
$functionsFolder = "$env:USERPROFILE\dev\dotfiles\psfunctions"
Get-ChildItem $functionsFolder | ForEach-Object {. "$($_.FullName)"}

Write-Host "$(U 0x1F680) Your shell is loaded! $(U 0x1F680)" -ForegroundColor Green
Write-Host "For a list of custom commands, run 'Get-CustomFunctions'" -ForegroundColor Blue

oh-my-posh --init --shell pwsh --config "$($env:USERPROFILE)\dev\dotfiles\psprofile\posh_profile.omp.json" | Invoke-Expression
