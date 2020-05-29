
# OS-specific setup
switch (uname)
    case Darwin
        # Set dev directory path
        set -gx DEV_FOLDER_PATH "~/Documents/dev"

        # Add GNU coreutils to path
        set -gx PATH /usr/local/opt/coreutils/libexec/gnubin $PATH

        # Set the color scheme for Bob the Fish; base16 on MacOs
        set -g theme_color_scheme base16

        # Setup pyenv for MacOS
        status --is-interactive; and source (pyenv init -|psub)

        # Setup rbenv for MacOS
        status --is-interactive; and source (rbenv init -|psub)

    case Linux
        # Set dev directory path
        set -gx DEV_FOLDER_PATH "/mnt/c/Users/bill.deitrick/dev"

        # Set an env variable indicating whether or not this is WSL
        # WSL detection inspired by https://stackoverflow.com/questions/38086185/how-to-check-if-a-program-is-run-in-bash-on-ubuntu-on-windows-and-not-just-plain
        if grep -qE "(Microsoft|WSL)" /proc/version
            set IS_WSL = 1
        else
            set IS_WSL = 0
        end

        # Set the color scheme for Bob the Fish; base16 on Linux
        set -g theme_color_scheme base16-light

        # Setup pyenv for Linux
        set -gx PYENV_ROOT "$HOME/.pyenv"
        set -gx PATH "$PYENV_ROOT/bin:$PATH"

        status --is-interactive; and source (pyenv init -|psub)

        # Setup user-level Python bin path
        set -gx PATH "$HOME/.local/bin:$PATH"

        # Setup rbenv for Linux
        set -gx RBENV_ROOT "$HOME/.rbenv"
        set -gx PATH "$RBENV_ROOT/bin:$PATH"

        status --is-interactive; and source (rbenv init -|psub)

        # Add bindings for command completion to CTRL/ALT+G on Linux
        # Otherwise, completion doesn't work in VSCode terminal
        function fish_user_key_bindings
            bind \cg forward-char
            bind \eg forward-word
        end
    case '*'
        echo "MY FISH DOESN'T KNOW THESE WATERS!"
end
