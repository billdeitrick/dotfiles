# User-specific tool and app standup for Bill's Windows setup
# Run this script in a PowerShell window running as whatever user will be
# using the machine

################################################################
# Modify System Path                                           #
################################################################

$pythonVerPath = $($(python --version).Replace('.', '').Replace(' ', '').Substring(0,8))

[Environment]::SetEnvironmentVariable("Path", $env:Path + ";" + $env:USERPROFILE + "\dev\dotfiles\batch_aliases", [System.EnvironmentVariableTarget]::User)
[Environment]::SetEnvironmentVariable("Path", $env:Path + ";" + $env:AppData + "\Python\$pythonVerPath\Scripts", [System.EnvironmentVariableTarget]::User)

################################################################
# Install Powershell Modules                                   #
################################################################

Write-Host "######### Install PowerShell Modules #########"

# Trust the PSGallery repository
Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted

# Ensure updated packages for NuGet, PowerShellGet
Install-Module -Name NuGet -Scope CurrentUser -Force
Install-Module -Name PowerShellGet -Scope CurrentUser -Force

Install-Module -Name MSOnline -Scope CurrentUser -Force
Install-Module -Name Az -Scope CurrentUser -Force
Install-Module -Name ExchangeOnline -Scope CurrentUser -Force
Install-Module -Name Pester -Scope CurrentUser -Force -SkipPublisherCheck # Otherwise this errs out
Install-Module -Name ImportExcel -Scope CurrentUser -Force
