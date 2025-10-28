# Windows requires admin rights for creating Symlinks, unless the developer mode
# option is enabled. I've found this to at times be unreliable, so I'm hacking this
# to run as admin.

# Get the current user profile path; this will be expanded when we pass off to an elevated shell below.
$USERPROFILE = $env:USERPROFILE

Start-Process powershell.exe -Verb Runas -ArgumentList "-Command & {

    Remove-Item -Path $USERPROFILE\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json -Force
    New-Item -Path $USERPROFILE\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json -ItemType SymbolicLink -Value $USERPROFILE\dev\dotfiles\windowsterminal\settings.json

    Remove-Item -Path '$USERPROFILE\.gitignore' -Force
    New-Item -Path '$USERPROFILE\.gitignore' -ItemType SymbolicLink -Value '$USERPROFILE\dev\dotfiles\.gitignore'

    # For debug
    # pause
}"
