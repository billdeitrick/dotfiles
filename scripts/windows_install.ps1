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
choco install vscode -y
choco install conemu -y
choco install fontforge -y
choco install docker-desktop -y
choco install typora -y
choco install ffmpeg -y

################################################################
# Install Desktop Software                                     #
################################################################

Write-Host "######### Install Desktop Software #########"

choco install 7zip -y
choco install audacity -y
choco install audacity-lame -y
choco install burp-suite-free-edition -y
choco install cloudberryexplorer.amazons3 -y
choco install conemu -y
choco install dymo-connect -y
choco install gimp -y
choco install hxd -y
choco install imgburn -y
choco install inkscape -y
choco install irfanview -y
choco install jitsi -y
choco install kdiff3 -y
choco install keepass -y
choco install firefox -y
choco install nmap -y
choco install notepadplusplus -y
choco install obs-studio -y
choco install orca -y
choco install pingplotter -y
choco install fiddler -y
choco install python -y
choco install slack -y
choco install winscp -y
choco install wireshark -y
choco install xmlnotepad -y
choco install putty -y
choco install rufus -y
choco install windirstat -y

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

################################################################
# Manual Install Applications                                  #
################################################################

Write-Host "######### The Following Apps Should Be Manually Installed #########"

Write-Host "* Adobe Acrobat Customization Wizard"
Write-Host "* Adobe Photoshop Elements 2019"
Write-Host "* Adobe Premiere Elements 2019"
Write-Host "* C2G A/V Controller Manager"
Write-Host "* Canon Remote Operation Viewer"
Write-Host "* Chanalyzer"
Write-Host "* Exacqvision"
Write-Host "* Eye P.A."
Write-Host "* GAM"
Write-Host "* Inssider"
Write-Host "* MirrorOp"
Write-Host "* Sketchup"
Write-Host "* Tamograph"
Write-Host "* RealVNC Viewer"
Write-Host "* PowerBI"
