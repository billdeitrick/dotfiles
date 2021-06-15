#!/bin/bash

# Stand up tools and apps for Bill's Work MacOS setup on ARM

################################################################
# Install Rosetta2                                             #
################################################################

echo "######### Install Rosetta2 #########" 
/usr/sbin/softwareupdate --install-rosetta --agree-to-license

################################################################
# Install XCode Tools                                          #
################################################################

echo "######### Install xcode-select tools #########" 
xcode-select --install

################################################################
# Install Homebrew                                             #
################################################################

echo "######### Install Homebrew #########"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

################################################################
# Install MAS                                                  #
################################################################

echo "######### Manage App Store Apps with MAS #########"
/opt/homebrew/bin/brew install mas

################################################################
# Pause                                                        #
################################################################

echo "######### Pause: Verify all operations so far. [Enter] to continue. #########"
read -p ""

################################################################
# Work Brewfile Install                                        #
################################################################

echo "######### Installing Apps from Brewfile #########"
/opt/homebrew/bin/brew bundle install --file ~/Documents/dev/dotfiles/scripts/Brewfile-Work --no-lock

################################################################
# Pause                                                        #
################################################################

echo "######### Pause: Verify all operations so far. [Enter] to continue. #########"
read -p ""

################################################################
# Fish!                                                        #
################################################################

echo "######### Configure FISH as the Default Shell #########"

# Add to /etc/shells (requires new bash with root for redirection to work)
sudo bash -c "echo /usr/local/bin/fish >> /etc/shells"

# Set Fish as default shell (more setup will happen from fish)
chsh -s /usr/local/bin/fish

# Get completions for Fish
mkdir ~/.config/fish/completions
curl -Lo ~/.config/fish/completions/docker.fish https://raw.githubusercontent.com/docker/cli/master/contrib/completion/fish/docker.fish

################################################################
# Pause                                                        #
################################################################

echo "######### Pause: Verify all operations so far. [Enter] to continue. #########"
read -p ""

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
  sudo rm -rf /Library/Applications/iMovie.app/
else
  echo "iMovie not found."
fi

# Remove Pages if it's installed
if mas list | grep 409201541 > /dev/null; then
  echo "Removing Pages."
  sudo rm -rf /Library/Applications/Pages.app/
else
  echo "Pages not found."
fi

# Remove Numbers if it's installed
if mas list | grep 409203825 > /dev/null; then
  echo "Removing Numbers."
  sudo rm -rf /Library/Applications/Numbers.app/
else
  echo "Numbers not found."
fi

# Remove Keynote if it's installed
if mas list | grep 409183694 > /dev/null; then
  echo "Removing Keynote."
  sudo rm -rf /Library/Applications/Keynote.app/
else
  echo "Keynote not found."
fi

################################################################
# Pause                                                        #
################################################################

echo "######### Pause: Verify all operations so far. [Enter] to continue. #########"
read -p ""

# TODO: Ensure idempotency for entire script
# TODO: Make pauses opt-in only
# TODO: Add system settings
## Touchpad enable tap to click
## Show file extensions
## Dock settings