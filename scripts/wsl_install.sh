#!/bin/bash

# Stand up tools and apps for Bill's Ubuntu (WSL) setup

# Global Vars
OS=$(lsb_release --id | awk '{print $3}' | tr '[:upper:]' '[:lower:]')
DIST=$(lsb_release --codename | awk '{print $2}' | tr '[:upper:]' '[:lower:]')

################################################################
# Update Packages Indexes and install Upgrades                 #
################################################################

echo "######### Update Packages Indexes and install Upgrades #########"

sudo apt-get update
sudo apt-get upgrade -y

################################################################
# Misc CLI utilities		                               #
################################################################

echo "######### Install Misc CLI Utils #########"

sudo apt-get install -y unzip
sudo apt-get install -y git
sudo apt-get install -y make
sudo apt-get install -y wget
sudo apt-get install -y vim
sudo apt-get install -y curl
sudo apt-get install -y screen
sudo apt-get install -y iperf
sudo apt-get install -y nmap

################################################################
# Dev dependencies		                               #
################################################################

echo "######### Install Misc Dev Dependencies #########"

sudo apt-get install -y llvm
sudo apt-get install -y libncurses5-dev
sudo apt-get install -y xz-utils
sudo apt-get install -y tk-dev
sudo apt-get install -y libxml2-dev
sudo apt-get install -y libxmlsec1-dev
sudo apt-get install -y libffi-dev
sudo apt-get install -y build-essential
sudo apt-get install -y libssl-dev
sudo apt-get install -y zlib1g-dev
sudo apt-get install -y libbz2-dev
sudo apt-get install -y libreadline-dev
sudo apt-get install -y libsqlite3-dev

################################################################
# Fish!                                                        #
################################################################

echo "######### Install Fish and Powerline Font #########"

# Install Fish 3
sudo apt-add-repository -y ppa:fish-shell/release-3
sudo apt-get update
sudo apt-get install -y fish

# Add to /etc/shells (requires new bash with root for redirection to work)
sudo bash -c "echo /usr/bin/fish >> /etc/shells"

# Set Fish as default shell (more setup will happen from fish)
chsh -s /usr/bin/fish

# Get a nerdfonts for Fish
sudo apt-get install -y fonts-hack-ttf

# Get completions for Fish
curl -Lo ~/.config/fish/completions/docker.fish https://raw.githubusercontent.com/docker/cli/master/contrib/completion/fish/docker.fish

################################################################
# Python                                                       #
################################################################

echo "######### Install Python #########"

# Install pyenv for managing Python installations
# Installing straight from GitHub to get the latest and greatest
curl https://pyenv.run | bash

# Set a var with the latest stable Python version...we'll use this multiple times (inspired by https://stackoverflow.com/questions/29687140/install-latest-python-version-with-pyenv)
# Note that we need to use the full path to pyenv here
PYTHON_LATEST=$(~/.pyenv/bin/pyenv install --list | sed 's/^  //' | grep --invert-match '\(-\|a\|b\dev\)' | tail -1)
PYTHON27=$(~/.pyenv/bin/pyenv install --list | sed 's/^  //' | grep --invert-match '\(-\|a\|b\dev\)' | grep 2[.]7 | tail -1)

# Get the latest stable Python versions from pyenv
~/.pyenv/bin/pyenv install $PYTHON27
~/.pyenv/bin/pyenv install $PYTHON_LATEST # Python 3 Latest

# Tell pyenv what our default Python will be
~/.pyenv/bin/pyenv global $PYTHON_LATEST

# Since pyenv shims won't actually be default yet, we'll call them explicitly to use latest python and get Pipenv
~/.pyenv/shims/pip install -U pipenv

# Done with Python...pipenv handles all other magic

################################################################
# Ruby                                                         #
################################################################

echo "######### Install Ruby #########" 

# Installing straight from github to get the latest and greatest
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-installer | bash

# Heroku
curl https://cli-assets.heroku.com/install.sh | bash

# Set a var with the latest stable Ruby version available from rbenv
# Use explicit paths since we don't have rbenv on PATH yet
RUBY_LATEST=$(~/.rbenv/bin/rbenv install --list | grep '^[0-9]\.[0-9]\.[0-9]$' | tail -1)

# Get the latest stable Ruby version from rbenv
~/.rbenv/bin/rbenv install $RUBY_LATEST

# Tell rbenv what our default Ruby will be
~/.rbenv/bin/rbenv global $RUBY_LATEST

# Install gems we'll want for dev
~/.rbenv/shims/gem install rubocop
~/.rbenv/shims/gem install ruby-debug-ide
~/.rbenv/shims/gem install debase

################################################################
# Node                                                         #
################################################################

echo "######### Install Node #########" 

# NVM install
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash

# This allows us to start using NVM immediately in the current session
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Next, we'll install the current LTS version of node
# See NVM readme for details
nvm install 'lts/*'

################################################################
# Node Modules                                                 #
################################################################

echo "######### Install Node Modules #########" 

npm install -g serverless
npm install -g yo 
npm install -g generator-serverless-policy
