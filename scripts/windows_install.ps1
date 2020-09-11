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
choco install docker-desktop -y
choco install typora -y

# Unused desktop apps
#choco install fontforge -y
#choco install ffmpeg -y

################################################################
# Install Desktop Software                                     #
################################################################

Write-Host "######### Install Desktop Software #########"

choco install 7zip -y
choco install hxd -y
choco install firefox -y
choco install nmap -y
choco install notepadplusplus -y
choco install orca -y
choco install fiddler -y
choco install python -y
choco install winscp -y
choco install wireshark -y
choco install xmlnotepad -y
choco install putty -y
choco install windirstat -y
choco install adobereader -y

# Unused desktop apps
#choco install audacity -y
#choco install audacity-lame -y
#choco install burp-suite-free-edition -y
#choco install cloudberryexplorer.amazons3 -y
#choco install dymo-connect -y
#choco install gimp -y
#choco install imgburn -y
#choco install inkscape -y
#choco install irfanview -y
#choco install jitsi -y
#choco install kdiff3 -y
#choco install keepass -y
#choco install chrome -y
#choco install obs-studio -y
#choco install pingplotter -y
#choco install slack -y
#choco install rufus -y
#choco install vcxsrv -y

# Cleanup
Remove-Item -Path 'C:\Users\Public\Desktop\ConEmu (x64).lnk' -Force

################################################################
# Install Powershell Modules                                   #
################################################################

Write-Host "######### Install PowerShell Modules #########"

# Trust the PSGallery repository
Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted

# Ensure updated packages for NuGet, PowerShellGet
Install-Module -Name NuGet -Force
Install-Module -Name PowerShellGet -Force

Install-Module -Name MSOnline -Force
Install-Module -Name Az -Force
Install-Module -Name ExchangeOnline -Force
Install-Module -Name Pester -Force -SkipPublisherCheck # Otherwise this errs out
