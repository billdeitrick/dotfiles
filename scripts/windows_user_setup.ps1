# User-specific tool and app standup for Bill's Windows setup
# Run this script in a PowerShell window running as whatever user will be
# using the machine

################################################################
# Modify System Path                                           #
################################################################

[Environment]::SetEnvironmentVariable("Path", $env:Path + ";" + $env:USERPROFILE + "\dev\dotfiles\batch_aliases", [System.EnvironmentVariableTarget]::User)

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
code --install-extension eamodio.gitlens
code --install-extension stormwarning.json-template

# Extensions for Windows only
code --install-extension ms-vscode.powershell
code --install-extension ms-vscode-remote.remote-wsl
