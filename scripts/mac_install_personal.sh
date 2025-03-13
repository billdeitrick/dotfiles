#!/bin/bash

# Stand up tools and apps for Bill's personal MacOs setup on ARM

################################################################
# Install Rosetta2                                             #
################################################################

# https://community.jamf.com/t5/jamf-pro/how-to-check-if-rosetta2-is-installed-macos-11-5/m-p/242581
echo "######### Install Rosetta2 #########" 
if ! /usr/bin/pgrep oahd >/dev/null 2>&1; then
  /usr/sbin/softwareupdate --install-rosetta --agree-to-license
else
  echo "Rosetta2 already installed."
fi

################################################################
# Install XCode Tools                                          #
################################################################

echo "######### Install xcode-select tools #########"
if ! xcode-select -p > /dev/null; then 
  xcode-select --install
else
  echo "Xcode command line tools already installed."
fi

################################################################
# Pause                                                        #
################################################################

if [[ ! -f "/Users/$LOGNAME/.dotfiles_install_complete" ]]; then
  echo "######### Pause: Verify all operations so far. [Enter] to continue. #########"
  read -p ""
fi

################################################################
# Install Homebrew                                             #
################################################################

echo "######### Install Homebrew #########"
if [[ ! -f "/opt/homebrew/bin/brew" ]]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "Homebrew already installed."
fi

################################################################
# Add Homebrew Bin to Path                                     #
################################################################

echo "######### Add Homebrew Binaries to Path #########"
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"

################################################################
# Install MAS                                                  #
################################################################

echo "######### Ensure MAS is Installed #########"
if ! brew list | grep mas > /dev/null; then
  brew install mas
else
  echo "mas is already installed."
fi

################################################################
# Pause                                                        #
################################################################

if [[ ! -f "/Users/$LOGNAME/.dotfiles_install_complete" ]]; then
  echo "######### Pause: Verify all operations so far. [Enter] to continue. #########"
  read -p ""
fi

################################################################
# Personal Brewfile Install                                    #
################################################################

echo "######### Installing Apps from Brewfile #########"
brew bundle install --file ~/Documents/dev/dotfiles/scripts/Brewfile-Personal

################################################################
# Pause                                                        #
################################################################

if [[ ! -f "/Users/$LOGNAME/.dotfiles_install_complete" ]]; then
  echo "######### Pause: Verify all operations so far. [Enter] to continue. #########"
  read -p ""
fi

################################################################
# Fish!                                                        #
################################################################

echo "######### Configure FISH as the Default Shell #########"
if ! grep fish /etc/shells > /dev/null; then
  # Add to /etc/shells (requires new bash with root for redirection to work)
  sudo bash -c "echo /opt/homebrew/bin/fish >> /etc/shells"

  # Set Fish as default shell (more setup will happen from fish)
  chsh -s /opt/homebrew/bin/fish

  # Get completions for Fish
  mkdir -p ~/.config/fish/completions
  curl -Lo ~/.config/fish/completions/docker.fish https://raw.githubusercontent.com/docker/cli/master/contrib/completion/fish/docker.fish
else
  echo "Fish is already installed."
fi

################################################################
# Pause                                                        #
################################################################

if [[ ! -f "/Users/$LOGNAME/.dotfiles_install_complete" ]]; then
  echo "######### Pause: Verify all operations so far. [Enter] to continue. #########"
  read -p ""
fi

################################################################
# Python                                                       #
################################################################

# Not working currently for some reason. Using HomeBrew python instead for now.
# echo "######### Install Python via pyenv #########"
# # If we've only got one Python version installed (system), install a few more
# if [ "$(pyenv versions | wc -l | xargs)" == "1" ]; then
#   # Set a var with the latest stable Python version...we'll use this multiple times (inspired by https://stackoverflow.com/questions/29687140/install-latest-python-version-with-pyenv)
#   PYTHON_LATEST=$(pyenv install --list | sed 's/^  //' | grep --invert-match '\(-\|a\|b\dev\|rc\|miniforge\)' | tail -1)

#   echo "Installing Python Latest"
#   arch -x86_64 pyenv install $PYTHON_LATEST

#   # Tell pyenv what our default Python will be
#   pyenv global $PYTHON_LATEST

#   # Install pipx
#   ~/.pyenv/shims/pip install -U pipx

#   # Install Python tools with pipx
#   ~/.pyenv/shims/pipx install pipenv
#   ~/.pyenv/shims/pipx install flake8
#   ~/.pyenv/shims/pipx install pytest
# else
#   echo "Python install with Pyenv already complete."
# fi

# Broken currently
# echo "######### Install Python tooling via Pipx #########"
# pip3 install -U pipx
# pipx install pipenv
# pipx install flake8
# pipx install pytest

################################################################
# Pause                                                        #
################################################################

if [[ ! -f "/Users/$LOGNAME/.dotfiles_install_complete" ]]; then
  echo "######### Pause: Verify all operations so far. [Enter] to continue. #########"
  read -p ""
fi

################################################################
# Ruby                                                         #
################################################################

# DISABLED ~> Not working with Ruby right now
# echo "######### Install Ruby via rbenv #########"
# # If we've only got one Ruby version installed (system), install latest
# if [ "$(rbenv versions | wc -l | xargs)" == "1" ]; then
# # Set a var with the latest stable Ruby version available from rbenv
#   RUBY_LATEST=$(rbenv install -L | grep '^[0-9]\.[0-9]\.[0-9]$' | tail -1)

#   # Get the latest stable Ruby version from rbenv
#   rbenv install $RUBY_LATEST

#   # Tell rbenv what our default Ruby will be
#   rbenv global $RUBY_LATEST
# else
#   echo "Ruby install with rbenv already complete."
# fi

################################################################
# Pause                                                        #
################################################################

if [[ ! -f "/Users/$LOGNAME/.dotfiles_install_complete" ]]; then
  echo "######### Pause: Verify all operations so far. [Enter] to continue. #########"
  read -p ""
fi

################################################################
# NVM Install                                                  #
################################################################

echo "######### Install NVM #########" 
# NVM install...not officially "supported" via brew
if [[ ! -f "/Users/$LOGNAME/.nvm/nvm.sh" ]]; then
  echo "Installing NVM."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
  echo "Done installing NVM."

  echo "Installing current LTS node version"
  # This allows us to start using NVM immediately in the current session
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

  # Next, we'll install the current LTS version of node
  # See NVM readme for details
  nvm install 'lts/*'
  echo "Done installing current LTS node version"
else
  echo "NVM already installed."
fi

################################################################
# Pause                                                        #
################################################################

if [[ ! -f "/Users/$LOGNAME/.dotfiles_install_complete" ]]; then
  echo "######### Pause: Verify all operations so far. [Enter] to continue. #########"
  read -p ""
fi

################################################################
# Cleanup unwanted default apps                                #
################################################################

echo "######### Cleanup unwanted default apps #########"

# Remove GarageBand if it's installed
if mas list | grep 682658836 > /dev/null; then
  echo "Removing GarageBand and cleaning up."
  sudo rm -rf /Applications/GarageBand.app/
  sudo rm -rf /Library/Application\ Support/GarageBand/
  sudo rm -rf /Library/Application\ Support/Logic/
  sudo rm -rf /Library/Audio/Apple\ Loops/
else
  echo "GarageBand not found."
fi

################################################################
# Pause                                                        #
################################################################

if [[ ! -f "/Users/$LOGNAME/.dotfiles_install_complete" ]]; then
  echo "######### Pause: Verify all operations so far. [Enter] to continue. #########"
  read -p ""
fi

################################################################
# Register SSH Agent Plist                                     #
################################################################

echo "######### Copy SSH Agent Key Registration Plist #########"

if [[ ! -f "/Users/$LOGNAME/Library/LaunchAgents/us.deitrick.registersshkeys.plist" ]]; then
  echo "Copying plist."
  cp "/Users/$LOGNAME/Documents/dev/dotfiles/macos/LaunchAgents/us.deitrick.registersshkeys.plist" "/Users/$LOGNAME/Library/LaunchAgents/us.deitrick.registersshkeys.plist"
else
  echo "Plist is already in place."
fi

################################################################
# Pause                                                        #
################################################################

if [[ ! -f "/Users/$LOGNAME/.dotfiles_install_complete" ]]; then
  echo "######### Pause: Verify all operations so far. [Enter] to continue. #########"
  read -p ""
fi

################################################################
# Settings                                                     #
################################################################

echo "######### Configure System Settings #########"

echo "Quitting System Preferences..."
osascript -e 'quit app "System Preferences"'
echo "...done."

echo "Enable Tap to Click"
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true

echo "Enable App Exposé"
defaults write com.apple.dock showAppExposeGestureEnabled -bool true

echo "Show All File Extensions"
defaults write -globalDomain AppleShowAllExtensions -bool true

echo "Configure Dock"
defaults write com.apple.dock magnification -bool true
defaults write com.apple.dock largesize -int 128
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock tilesize -int 64

killall "Dock"
killall "Finder"

################################################################
# Manual Settings                                              #
################################################################

# TODO: Convert manual settings to AppleScript

if [[ ! -f "/Users/$LOGNAME/.dotfiles_install_complete" ]]; then
  echo "######### Manual Configuration Settings #########"
  echo "Set the following settings manually that can't be automated with defaults:"
  echo ""
  echo ">> Sound <<"
  echo "+ Settings > Sounds > Play feedback when volume is changed"
  echo "+ Settings > Sounds > Show volume in menu bar"
  echo ""
  echo ">> Keyboard Shortcuts <<"
  echo "Settings > Keyboard > Shortcuts > Mission Control > Mission Control: CTRL + CMD + UP"
  echo "Settings > Keyboard > Shortcuts > Mission Control > Application Windows: CTRL + CMD + DOWN"
  echo "Settings > Keyboard > Shortcuts > Mission Control > Application Windows: CTRL + CMD + DOWN"
  echo "Settings > Keyboard > Shortcuts > Mission Control > Move left a space: CTRL + CMD + LEFT"
  echo "Settings > Keyboard > Shortcuts > Mission Control > Move right a space: CTRL + CMD + RIGHT"
  echo ""
  echo ">>SSH Agent<<"
  echo "Register ssh keys using keychain for passwordless use. Execute /usr/bin/ssh-add -K and follow prompts."
fi

################################################################
# Pause                                                        #
################################################################

if [[ ! -f "/Users/$LOGNAME/.dotfiles_install_complete" ]]; then
  echo "######### Pause: Verify all operations so far. [Enter] to continue. #########"
  read -p ""
fi

################################################################
# Pause Disable                                                #
################################################################

if [[ ! -f "/Users/$LOGNAME/.dotfiles_install_complete" ]]; then
  echo "######### Dotfiles Setup Complete Flag #########"
  echo "Creating setup complete flag file."
  touch "/Users/$LOGNAME/.dotfiles_install_complete"
fi
