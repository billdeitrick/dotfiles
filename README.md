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
/usr/local/bin/fish scripts/symlink.fish
/usr/local/bin/fish scripts/fish-bootstrap.fish
```

### Windows

### Set Up Windows

Some apps on Windows can't be installed via Chocolatey; they come from the Windows store, other less easily accessible sources, etc. Here is a list of manual setup to be performed:

1. Install password manager
1. Enable HyperV (`Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All`)
1. Install MS Office if applicable
1. Install Windows terminal from windows store
1. Download dotfiles repo from github. Drop anywhere, extract, and run from admin PowerShell: `.\scripts\windows_install.ps1`
1. Clone the dotfiles repo into %UserProfile%\dev
1. CD into $UserProfile%\dev and run `.\scripts\windows_user_setup.ps1` and `.\scripts\symlink.ps1`

Follow Microsoft [instructions for installing WSL 2](https://docs.microsoft.com/en-us/windows/wsl/install-win10).

#### Set Up WSL

1. Open WSL, cd into `dev/dotfiles`
1. Run install script: `/bin/bash scripts/wsl_install.sh`
1. Run fish script: `/usr/bin/fish scripts/symlink.fish`
1. Run fish script: `/usr/bin/fish scripts/fish-bootstrap.fish`

### Symlinking (for all Operating Systems)

When adding new managed dotfiles, run the symlink script to pick them up automatically (if they are managed by this script) or add them to the symlink script so they will be managed automatically.

Run the appropriate symlink file for the OS--for Unices, run scripts/symlink.fish. For Windoze, run scripts/symlink.ps1.
