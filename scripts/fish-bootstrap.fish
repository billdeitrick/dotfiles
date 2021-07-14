#! /usr/bin/env fish

# Get fisher
curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish

# Fish file should already be in place...update plugins
fisher update

# Add NVM aliases if they don't exist
echo "If you haven't created NVM binary aliases, do this with `sudo fish` and then `nvm_alias_command` in the shell with super powers."