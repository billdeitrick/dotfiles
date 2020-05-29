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
code --install-extension ms-azuretools.vscode-docker
code --install-extension eamodio.gitlens
code --install-extension stormwarning.json-template
code --install-extension ms-vscode-remote.remote-containers

# Extensions for Windows only
code --install-extension ms-vscode.powershell
code --install-extension ms-vscode-remote.remote-wsl

################################################################
# Install Python Stuff                                         #
################################################################

Write-Host "######### Install Python Stuff #########"

pip install --user pipenv
pip install --user cookiecutter
pip install --user cruft