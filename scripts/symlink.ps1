# Windows requires admin rights for creating Symlinks, unless the developer mode
# option is enabled. I've found this to at times be unreliable, so I'm hacking this
# to run as admin.

# Get the current user profile path; this will be expanded when we pass off to an elevated shell below.
$USERPROFILE = (Get-Item Env:USERPROFILE).value

Start-Process powershell.exe -Verb Runas -ArgumentList "-Command & {
    # Hyper
    Remove-Item -Path $USERPROFILE\.hyper.js
    New-Item -Path $USERPROFILE\.hyper.js -ItemType SymbolicLink -Value $USERPROFILE\Documents\dev\dotfiles\.hyper.js

    # VSCode
    Remove-Item -Path $USERPROFILE\AppData\Roaming\Code\User\settings.json
    New-Item -Path $USERPROFILE\AppData\Roaming\Code\User\settings.json -ItemType SymbolicLink -Value $USERPROFILE\Documents\dev\dotfiles\VSCode\settings.json
    
    # Git
    Remove-Item -Path $USERPROFILE\.gitconfig
    New-Item -Path $USERPROFILE\.gitconfig -ItemType SymbolicLink -Value $USERPROFILE\Documents\dev\dotfiles\.gitconfig

    Remove-Item -Path $USERPROFILE\.gitignore
    New-Item -Path $USERPROFILE\.gitignore -ItemType SymbolicLink -Value $USERPROFILE\Documents\dev\dotfiles\.gitignore

    # For debug
    #pause
}"