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
code --install-extension DavidAnson.vscode-markdownlint
code --install-extension eamodio.gitlens
code --install-extension esbenp.prettier-vscode
code --install-extension hbenl.vscode-test-explorer
code --install-extension KnisterPeter.vscode-github
code --install-extension mikestead.dotenv
code --install-extension mohsen1.prettify-json
code --install-extension ms-azure-devops.azure-pipelines
code --install-extension ms-azuretools.vscode-azurefunctions
code --install-extension ms-azuretools.vscode-docker
code --install-extension ms-dotnettools.csharp
code --install-extension ms-dotnettools.vscode-dotnet-runtime
code --install-extension ms-python.python
code --install-extension ms-toolsai.jupyter
code --install-extension ms-vscode-remote.remote-containers
code --install-extension ms-vscode-remote.remote-ssh
code --install-extension ms-vscode-remote.remote-ssh-edit
code --install-extension ms-vscode-remote.remote-wsl
code --install-extension ms-vscode.azure-account
code --install-extension ms-vscode.powershell-preview
code --install-extension msazurermtools.azurerm-vscode-tools
code --install-extension rebornix.ruby
code --install-extension ryanluker.vscode-coverage-gutters
code --install-extension samuelcolvin.jinjahtml
code --install-extension skyapps.fish-vscode
code --install-extension TylerLeonhardt.vscode-pester-test-adapter
code --install-extension wingrunr21.vscode-ruby

################################################################
# Install Python Stuff                                         #
################################################################

Write-Host "######### Install Python Stuff #########"

pip install --user pipenv
pip install --user cookiecutter
pip install --user cruft