# User-specific tool and app standup for Bill's Windows setup
# Run this script in a PowerShell window running as whatever user will be
# using the machine

################################################################
# Install Code Extensions                                      #
################################################################

Write-Host "######### Install Code Extensions #########"

code --install-extension skyapps.fish-vscode
code --install-extension mikestead.dotenv
code --install-extension knisterpeter.vscode-github
code --install-extension esbenp.prettier-vscode
code --install-extension mohsen1.prettify-json
code --install-extension ms-python.python
code --install-extension ms-vscode.powershell