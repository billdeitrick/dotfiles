#!/bin/bash

# Stand up tools and apps for Bill's MacOS setup without any dev stuff

################################################################
# Install XCode Tools                                          #
################################################################

echo "######### Install xcode-select tools #########" 

# Get xcode tools
xcode-select --install

################################################################
# Install homebrew, setup autoupdates                          #
################################################################

echo "######### Install homebrew, setup auto-updates #########"

# Get homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Create ~/Library/LaunchAgents if it doesn't exist to avoid error with brew autoupdate
mkdir /Users/$(whoami)/Library/LaunchAgent:

# Add brew autoupdate, notifications (incl. terminal-notifier for notifications)
brew install terminal-notifier
brew tap domt4/autoupdate
brew autoupdate --start --upgrade --cleanup --enable-notifications

################################################################
# Manage App Store Apps with MAS                               #
################################################################

echo "######### Manage App Store Apps with MAS #########"

# Install mas to automate App Store downloads
brew install mas

# Remove GarageBand if it's installed...get that space back
if mas list | grep 682658836 > /dev/null; then
  echo "@#@# Bill: Removing GarageBand."
  sudo rm -rf /Applications/GarageBand.app/
  sudo rm -rf /Library/Application\ Support/GarageBand/
  sudo rm -rf /Library/Application\ Support/Logic/
  sudo rm -rf /Library/Audio/Apple\ Loops/
else
  echo "@#@# Bill: No GarageBand found. Yippee!"
fi

# Remove iMovie if it's installed...get that space back as well
if mas list | grep 408981434 > /dev/null; then
  echo "@#@# Bill: Removing iMovie."
  sudo rm -rf /Library/Applications/iMovie.app/
else
  echo "@#@# Bill: No iMovie found. Yippee!"
fi

# Install desired apps from app store
mas install 409183694 # Keynote
mas install 409201541 # Pages
mas install 409203825 # Numbers
mas install 803453959 # Slack
mas install 1295203466 # MS Remote Desktop 10
mas install 784801555 # MS OneNote

################################################################
# Manage Homebrew GUI Apps                                     #
################################################################

echo "######### Install non-mas apps with Homebrew #########"

# Install HomeBrew GUI apps
brew cask install osxfuse
brew cask install cryptomator
brew cask install google-backup-and-sync
brew cask install gnucash
brew cask install keepassx
brew cask install google-chrome
