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

Write-Host "######### Install Dev Stuff #########"

choco install git -y --params "/GitOnlyOnPath /NoAutoCrlf /WindowsTerminal /NoShellIntegration"
choco install hackfont-windows -y
choco install vscode -y --params "/NoDesktopIcon"
choco install conemu -y
choco install fontforge -y

# Cleanup
Remove-Item -Path 'C:\Users\Public\Desktop\ConEmu (x64).lnk' -Force

################################################################
# Install Powershell Modules                                   #
################################################################

Write-Host "######### Install PowerShell Modules #########"

# Trust the PSGallery repository
Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted

Install-Module MSOnline -Force
Install-Module Azure -Force
Install-Module ExchangeOnline -Force
