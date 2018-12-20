# dotfiles

Sets up my preferred development config for Mac and Linux environments. Uses [Hyper]() and [Fish](https://github.com/fish-shell/fish-shell) shell with [bobthefish](https://github.com/oh-my-fish/theme-bobthefish) theme (on Unices...PowerShell is default on Windows). 

Inspired by:
* [kennethreitz/dotfiles](https://github.com/kennethreitz/dotfiles)
* [mathiasbynens/dotfiles](https://github.com/mathiasbynens/dotfiles)
* [andrewconnell/osxinstall](https://github.com/andrewconnell/osx-install)

## Usage

The goal is to automate as much app and dev toolchain setup as possible. Here's how to run scripts and get everything set up:

### MacOS

```bash
/bin/bash scripts/mac_install.sh
/usr/local/bin/fish scripts/fish-bootstrap.fish
/usr/local/bin/fish scripts/symlink.fish
```

### Windows

```powershell
# Must run this as a local admin
.\scripts\windows_install.ps1

# Must run these as standard user
# Symlink will require elevation
.\scripts\windows_user_setup.ps1
.\scipts\symlink.ps1
```

#### WSL

```bash
/bin/bash scripts/wsl_install.sh
/usr/bin/fish scripts/symlink.fish
/usr/bin/fish scripts/fish-bootstrap.fish
```

### Symlinking (for all Operating Systems)

When adding new managed dotfiles, run the symlink script to pick them up automatically (if they are managed by this script) or add them to the symlink script so they will be managed automatically.

Run the appropriate symlink file for the OS--for Unices, run scripts/symlink.fish. For Windoze, run scripts/symlink.ps1.