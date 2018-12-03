# dotfiles

Sets up my preferred development config for Mac and Linux environments. Uses [Fish](https://github.com/fish-shell/fish-shell) shell with [bobthefish](https://github.com/oh-my-fish/theme-bobthefish) theme. 

Inspired by:
* [kennethreitz/dotfiles](https://github.com/kennethreitz/dotfiles)
* [mathiasbynens/dotfiles](https://github.com/mathiasbynens/dotfiles)
* [andrewconnell/osxinstall](https://github.com/andrewconnell/osx-install)

## Usage

The goal is to automate as much app and dev toolchain setup as possible. Here's how to run scripts and get everything set up:

```bash
/bin/bash scripts/(mac|linux)_install.sh
/usr/local/bin/fish scripts/fish-bootstrap.fish
/usr/local/bin/fish scripts/symlink.fish
```

When adding new managed dotfiles, run the symlink script to pick them up automatically (if they are managed by this script) or add them to the symlink script so they will be managed automatically.