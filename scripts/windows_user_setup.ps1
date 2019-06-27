# User-specific tool and app standup for Bill's Windows setup
# Run this script in a PowerShell window running as whatever user will be
# using the machine

################################################################
# Modify System Path                                           #
################################################################

[Environment]::SetEnvironmentVariable("Path", $env:Path + ";" + $env:USERPROFILE + "\Documents\dev\dotfiles\batch_aliases", [System.EnvironmentVariableTarget]::User)

################################################################
# Install Code Extensions                                      #
################################################################

Write-Host "######### Install Code Extensions #########"

# Extensions for all
code --install-extension skyapps.fish-vscode
code --install-extension mikestead.dotenv
code --install-extension knisterpeter.vscode-github
code --install-extension esbenp.prettier-vscode
code --install-extension mohsen1.prettify-json
code --install-extension ms-python.python
code --install-extension rebornix.ruby
code --install-extension samuelcolvin.jinjahtml
code --install-extension peterjausovec.vscode-docker

# Extensions for Windows only
code --install-extension ms-vscode.powershell