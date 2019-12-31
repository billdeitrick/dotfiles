#! /usr/local/bin/fish

# Set appropriate path depending on OS
switch (uname)
    case Darwin
        set DOTFILE_SYMLINK_ROOT "~/Documents/dev/dotfiles"
    case Linux
        set DOTFILE_SYMLINK_ROOT "/mnt/c/Users/bill.deitrick/dev/dotfiles"

        # WSL detection inspired by https://stackoverflow.com/questions/38086185/how-to-check-if-a-program-is-run-in-bash-on-ubuntu-on-windows-and-not-just-plain
        if grep -qE "(Microsoft|WSL)" /proc/version
            set IS_SYMLINK_WSL 1
        else
            set IS_SYMLINK_WSL 0
        end
    case '*'
        echo "MY FISH DOESN'T KNOW THESE WATERS!"
        exit 1

end

# Fish

## Fish config and functions 

### config.fish
rm ~/.config/fish/config.fish
ln -s $DOTFILE_SYMLINK_ROOT/.config/fish/config.fish ~/.config/fish/config.fish

### fishfile
rm ~/.config/fish/fishfile
ln -s $DOTFILE_SYMLINK_ROOT/.config/fish/fishfile ~/.config/fish/fishfile

### All custom Fish functions
if not test -e ~/.config/fish/functions
    mkdir ~/.config/fish/functions
end

for funcfile in $DOTFILE_SYMLINK_ROOT/.config/fish/functions/*
    set funcfiledest (echo ~/.config/fish/functions/(echo $funcfile | tr '/' '\n' | tail -1))

    if not test -e $funcfiledest
        ln -s $funcfile $funcfiledest
    end
end

# vscode

## Symlink all dotfiles in VSCode folder
for filesrc in $DOTFILE_SYMLINK_ROOT/VSCode/*
    switch (uname)
        case Darwin
            set filedst (echo ~/Library/Application\ Support/Code/User/(echo $filesrc | tr '/' '\n' | tail -1))

            if test -e $filedst
                rm $filedst
            end

            ln -s $filesrc $filedst
        case Linux
            # We only do this if not WSL (we don't install VSCODE in WSL)
            if test IS_SYMLINK_WSL = 0
                set filedst (echo ~/.config/Code/User/(echo $filesrc | tr '/' '\n' | tail -1))

                if test -e $filedst
                    rm $filedst
                end

                ln -s $filesrc $filedst
            end
        case '*'
            echo "No VSCode symlinks for this os."
            break
    end

end

# git

## .gitconfig
rm ~/.gitconfig
ln -s $DOTFILE_SYMLINK_ROOT/.gitconfig ~/.gitconfig

## .gitignore
rm ~/.gitignore
ln -s $DOTFILE_SYMLINK_ROOT/.gitignore ~/.gitignore