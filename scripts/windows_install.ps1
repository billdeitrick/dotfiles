# Stand up tools and apps for Bill's Windows setup
# Run this script in a PowerShell window with admin powers

################################################################
# Install Chocolatey                                           #
################################################################

Write-Host "######### Install Chocolatey #########"

Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Choco features
choco feature enable -n=useRememberedArgumentsForUpgrades

################################################################
# Install Dev                                                  #
################################################################

Write-Host "######### Install Dev #########"

choco install hackfont-windows -y
choco install vscode -y --params "/NoDesktopIcon"
choco install hyper -y

