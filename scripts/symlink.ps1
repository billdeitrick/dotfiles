# Windows requires admin rights for creating Symlinks, unless the developer mode
# option is enabled. I've found this to at times be unreliable, so I'm hacking this
# to run as admin.

# Get the current user profile path; this will be expanded when we pass off to an elevated shell below.
$USERPROFILE = $env:USERPROFILE

Start-Process powershell.exe -Verb Runas -ArgumentList "-Command & {
    # Conemu
    Remove-Item -Path $USERPROFILE\AppData\Roaming\ConEmu.xml -Force
    New-Item -Path $USERPROFILE\AppData\Roaming\ConEmu.xml -ItemType SymbolicLink -Value $USERPROFILE\dev\dotfiles\conemu\ConEmu.xml

    # VSCode
    Remove-Item -Path $USERPROFILE\AppData\Roaming\Code\User\settings.json -Force
    New-Item -Path $USERPROFILE\AppData\Roaming\Code\User\settings.json -ItemType SymbolicLink -Value $USERPROFILE\dev\dotfiles\VSCode\settings.json
    
    # Git
    Remove-Item -Path $USERPROFILE\.gitconfig -Force
    New-Item -Path $USERPROFILE\.gitconfig -ItemType SymbolicLink -Value $USERPROFILE\dev\dotfiles\.gitconfig

    Remove-Item -Path $USERPROFILE\.gitignore -Force
    New-Item -Path $USERPROFILE\.gitignore -ItemType SymbolicLink -Value $USERPROFILE\dev\dotfiles\.gitignore

    # PS Profile
    Remove-Item -Path $USERPROFILE\WindowsPowerShell\Microsoft.PowerShell_profile.ps1 -Force
    New-Item -Path $USERPROFILE\WindowsPowerShell\Microsoft.PowerShell_profile.ps1 -ItemType SymbolicLink -Value $USERPROFILE\dev\dotfiles\psprofile\Microsoft.PowerShell_profile.ps1

    # For debug
    #pause
}"
