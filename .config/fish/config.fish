
# OS-specific setup
switch (uname)
    case Darwin
        # Add GNU coreutils to path
        set -gx PATH /usr/local/opt/coreutils/libexec/gnubin $PATH

        # Set the color scheme for Bob the Fish; base16 on MacOs
        set -g theme_color_scheme base16

        # Setup pyenv for MacOS
        status --is-interactive; and source (pyenv init -|psub)

        # Setup rbenv for MacOS
        status --is-interactive; and source (rbenv init -|psub)

    case Linux
        # Set the color scheme for Bob the Fish; base16 on Linux
        set -g theme_color_scheme base16

        # Setup pyenv for Linux
        set -gx PYENV_ROOT "$HOME/.pyenv"
        set -gx PATH "$PYENV_ROOT/bin:$PATH"

        status --is-interactive; and source (pyenv init -|psub)

        # Setup rbenv for Linux
        #status --is-interactive; and source (rbenv init -|psub)

    case '*'
        echo "MY FISH DOESN'T KNOW THESE WATERS!"
end
