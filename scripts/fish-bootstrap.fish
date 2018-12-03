#!/usr/local/bin/fish

# Get fisher
curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish

# Fish file should already be in place...update plugins
fisher
