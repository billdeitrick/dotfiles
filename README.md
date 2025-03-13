# dotfiles

Sets up my preferred config for Mac, Windows, and Linux environments.

Inspired by:
* [kennethreitz/dotfiles](https://github.com/kennethreitz-archive/dotfiles)
* [mathiasbynens/dotfiles](https://github.com/mathiasbynens/dotfiles)
* [andrewconnell/osxinstall](https://github.com/andrewconnell/osx-install)

## Usage

The goal is to automate as much app and dev toolchain setup as possible. Here's how to run scripts and get everything set up:

### MacOS

Before running setup scripts, perform the following:
1. Ensure that the Terminal app has full disk permissions
2. Ensure that you have signed in to the Mac App Store

```bash
# Run one of the following bash scripts
/bin/bash scripts/mac_install_work.sh
/bin/bash scripts/mac_install_personal.sh

# Run the following two fish scripts
/opt/homebrew/bin/fish scripts/symlink.fish
/opt/homebrew/bin/fish scripts/fish-bootstrap.fish
```

### Windows

### Set Up Windows

Some apps on Windows aren't installed automatically for various reasons (broken packages, desire to actually use installers or other means, etc. Those are listed below).

Here are the steps to stand up a new Windows machine:

1. Install latest patches
1. Sign in to Microsoft Store (more likely that installs will succeed if signed in)
1. Ensure "App Installer" is installed from the Windows Store and up to date (and make sure `winget` can be run from shell)
1. Install password manager
1. Download dotfiles repo from github. Drop anywhere, extract, and run from admin PowerShell: `.\scripts\Install-AppsAndFeaturesAsAdmin.ps1` (add `-Personal` switch if this is a personal machine)
1. Clone the dotfiles repo into %UserProfile%\dev
1. CD into $UserProfile%\dev\dotfiles and run `.\scripts\Install-ResourcesAsUser.ps1` and `.\scripts\symlink.ps1`

Follow Microsoft [instructions for installing WSL 2](https://docs.microsoft.com/en-us/windows/wsl/install-win10).

#### Set Up WSL

1. Open WSL, cd into `dev/dotfiles`
1. Run install script: `/bin/bash scripts/wsl_install.sh`
1. Run fish script: `/usr/bin/fish scripts/symlink.fish`
1. Run fish script: `/usr/bin/fish scripts/fish-bootstrap.fish`

### Symlinking (for all Operating Systems)

When adding new managed dotfiles, run the symlink script to pick them up automatically (if they are managed by this script) or add them to the symlink script so they will be managed automatically.

Run the appropriate symlink file for the OS--for Unices, run scripts/symlink.fish. For Windoze, run scripts/symlink.ps1.
