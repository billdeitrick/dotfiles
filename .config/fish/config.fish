
# Set the color scheme for Bob the Fish
set -g theme_color_scheme base16

# OS-specific setup
switch (uname)
    case Darwin
        # Add GNU coreutils to path
        set -gx PATH /usr/local/opt/coreutils/libexec/gnubin $PATH

        # Setup pyenv for MacOS
        status --is-interactive; and source (pyenv init -|psub)

    case '*'
        echo "MY FISH DOESN'T KNOW THESE WATERS!"
end