#!/bin/bash

# Stand up tools and apps for Bill's Work MacOS setup on ARM

################################################################
# Install Rosetta2                                             #
################################################################

echo "######### Install Rosetta2 #########" 
if [[ ! -f "/Library/Apple/System/Library/LaunchDaemons/com.apple.oahd.plist" ]]; then
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
# Work Brewfile Install                                        #
################################################################

echo "######### Installing Apps from Brewfile #########"
brew bundle install --file ~/Documents/dev/dotfiles/scripts/Brewfile-Work --no-lock

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
# NVM Install                                                  #
################################################################

echo "######### Install NVM #########" 
# NVM install...not officially "supported" via brew
if [[ ! -f "/Users/$LOGNAME/.nvm/nvm.sh" ]]; then
  echo "Installing NVM."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
  echo "Done installing NVM."
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

# Remove iMovie if it's installed
if mas list | grep 408981434 > /dev/null; then
  echo "Removing iMovie."
  sudo rm -rf /Applications/iMovie.app/
else
  echo "iMovie not found."
fi

# Remove Pages if it's installed
if mas list | grep 409201541 > /dev/null; then
  echo "Removing Pages."
  sudo rm -rf /Applications/Pages.app/
else
  echo "Pages not found."
fi

# Remove Numbers if it's installed
if mas list | grep 409203825 > /dev/null; then
  echo "Removing Numbers."
  sudo rm -rf /Applications/Numbers.app/
else
  echo "Numbers not found."
fi

# Remove Keynote if it's installed
if mas list | grep 409183694 > /dev/null; then
  echo "Removing Keynote."
  sudo rm -rf /Applications/Keynote.app/
else
  echo "Keynote not found."
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
