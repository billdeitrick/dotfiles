#! /usr/local/bin/fish

# Hyper

## .hyper.js
rm ~/.hyper.js
ln -s ~/Documents/dev/dotfiles/.hyper.js ~/.hyper.js

# Fish

## Fish config and functions 

### config.fish
rm ~/.config/fish/config.fish
ln -s ~/Documents/dev/dotfiles/.config/fish/config.fish ~/.config/fish/config.fish

### fishfile
rm ~/.config/fish/fishfile
ln -s ~/Documents/dev/dotfiles/.config/fish/fishfile ~/.config/fish/fishfile

### All custom Fish functions
for funcfile in ~/Documents/dev/dotfiles/.config/fish/functions/*
    set funcfiledest (echo ~/.config/fish/functions/(echo $funcfile | tr '/' '\n' | tail -1))

    if not test -e $funcfiledest
        ln -s $funcfile $funcfiledest
    end
end

# vscode

## Symlink all dotfiles in VSCode folder
for filesrc in ~/Documents/dev/dotfiles/VSCode/*
    switch (uname)
        case Darwin
            set filedst (echo ~/Library/Application\ Support/Code/User/(echo $filesrc | tr '/' '\n' | tail -1))
        case '*'
            echo "Unrecognized OS! Can't setup VSCode symlinks"
            break
    end

    if test -e $filedst
        rm $filedst
    end

    ln -s $filesrc $filedst

end

# git

## .gitconfig
rm ~/.gitconfig
ln -s ~/Documents/dev/dotfiles/.gitconfig ~/.gitconfig