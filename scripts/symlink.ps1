# Windows requires admin rights for creating Symlinks, unless the developer mode
# option is enabled. I've found this to at times be unreliable, so I'm hacking this
# to run as admin.

# Get the current user profile path; this will be expanded when we pass off to an elevated shell below.
$USERPROFILE = $env:USERPROFILE

# Get the current OneDrive path; we assume KFM is used if OneDrive path is defined
# String escaping here is a little wonky; this is necessary because with single ' powershell
# won't expand the variables. But, we need to enclose the path in '' so it is parsed correctly.
if ($env:OneDrive) {
    $PSPROFILEPATH = "`'$env:ONEDRIVE\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1`'"
} else {
    $PSPROFILEPATH = "$USERPROFILE\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"
}

Start-Process powershell.exe -Verb Runas -ArgumentList "-Command & {

    # VSCode
    Remove-Item -Path $USERPROFILE\AppData\Roaming\Code\User\settings.json -Force
    New-Item -Path $USERPROFILE\AppData\Roaming\Code\User\settings.json -ItemType SymbolicLink -Value $USERPROFILE\dev\dotfiles\VSCode\settings.json

    # Git
    Remove-Item -Path $USERPROFILE\.gitconfig -Force
    New-Item -Path $USERPROFILE\.gitconfig -ItemType SymbolicLink -Value $USERPROFILE\dev\dotfiles\.gitconfig

    Remove-Item -Path $USERPROFILE\.gitignore -Force
    New-Item -Path $USERPROFILE\.gitignore -ItemType SymbolicLink -Value $USERPROFILE\dev\dotfiles\.gitignore

    # PS Profile
    Remove-Item -Path $PSPROFILEPATH -Force
    New-Item -Path $PSPROFILEPATH -ItemType SymbolicLink -Value $USERPROFILE\dev\dotfiles\psprofile\Microsoft.PowerShell_profile.ps1

    # For debug
    #pause
}"
