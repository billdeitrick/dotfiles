
# OS-specific setup
switch (uname)
    case Darwin
        # Set dev directory path
        set -gx DEV_FOLDER_PATH ~/Documents/dev

        # Set the color scheme for Bob the Fish; base16 on MacOs
        set -g theme_color_scheme base16

        # Add GNU coreutils to path
        if test -d /usr/local/opt/coreutils/libexec/gnubin
            set -gx PATH /usr/local/opt/coreutils/libexec/gnubin $PATH
        else
            # Update PATH
            ## Override MacOS utilities with GNU/HomeBrew
            set -gx PATH "/opt/homebrew/opt/coreutils/libexec/gnubin" $PATH
            set -gx PATH "/opt/homebrew/opt/findutils/libexec/gnubin" $PATH
            set -gx PATH "/opt/homebrew/opt/grep/libexec/gnubin" $PATH
            set -gx PATH "/opt/homebrew/opt/gnu-sed/libexec/gnubin" $PATH
            set -gx PATH "/opt/homebrew/opt/gnu-tar/libexec/gnubin" $PATH
            set -gx PATH "/opt/homebrew/opt/gnu-which/libexec/gnubin" $PATH
            set -gx PATH "/opt/homebrew/opt/make/libexec/gnubin" $PATH
            set -gx PATH "/opt/homebrew/opt/unzip/libexec/gnubin" $PATH
            set -gx PATH "/opt/homebrew/opt/unzip/bin" $PATH
            set -gx PATH "/opt/homebrew/opt/openssl/bin" $PATH
            set -gx PATH "/opt/homebrew/opt/python@3.9/libexec/bin" $PATH # Overrides system Python with brew 3.9

            ## Brew bin dirs
            set -gx PATH "/opt/homebrew/bin" $PATH
            set -gx PATH "/opt/homebrew/sbin" $PATH

            ## Add ~/.local/bin to path for pipx
            set -gx PATH "/Users/$LOGNAME/.local/bin" $PATH
        end

        # Setup pyenv for MacOS if it is available
        which pyenv > /dev/null 2>&1
        if test $status -eq 0
            status --is-interactive; and source (pyenv init -|psub)
        end

        # Setup rbenv for MacOs if it is available
        which rbenv > /dev/null 2>&1
        if test $status -eq 0
            status --is-interactive; and source (rbenv init -|psub)
        end

    case Linux
        # Set dev directory path, assuming WSL for now; can fix later if need be
        set -gx DEV_FOLDER_PATH "/mnt/c/Users/$LOGNAME/dev"

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
