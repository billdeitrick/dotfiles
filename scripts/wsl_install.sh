#!/bin/bash

# Stand up tools and apps for Bill's WSL setup

################################################################
# Update Packages Indexes and install Upgrades                 #
################################################################

echo "######### Update Packages Indexes and install Upgrades #########"

sudo apt-get update
sudo apt-get upgrade -y

################################################################
# Misc utils and Pyenv dependencies                            #
################################################################

echo "######### Install Misc Utils, Pyenv dependencies #########"

sudo apt-get install -y unzip
sudo apt-get install -y git
sudo apt-get install -y make
sudo apt-get install -y build-essential
sudo apt-get install -y libssl-dev
sudo apt-get install -y zlib1g-dev
sudo apt-get install -y libbz2-dev
sudo apt-get install -y libreadline-dev
sudo apt-get install -y libsqlite3-dev
sudo apt-get install -y wget
sudo apt-get install -y curl
sudo apt-get install -y llvm
sudo apt-get install -y libncurses5-dev
sudo apt-get install -y xz-utils
sudo apt-get install -y tk-dev
sudo apt-get install -y libxml2-dev
sudo apt-get install -y libxmlsec1-dev
sudo apt-get install -y libffi-dev

################################################################
# Fish!                                                        #
################################################################

echo "######### Install Fish #########"

# Install Fish
sudo apt-get install -y fish

# Set Fish as default shell (more setup will happen from fish)
chsh -s /usr/bin/fish

################################################################
# Python dev stuff basics                                      #
################################################################

echo "######### Install Python Dev Stuff #########"

# Install Pyenv for managing Pythons
git clone https://github.com/pyenv/pyenv.git ~/.pyenv # Clone repo

# Temporarily add pyenv root env var (not 100% sure if this is necessary, but just in case)
export PYENV_ROOT="$HOME/.pyenv"

# Also add env vars to .bash_profile, though this will probably never be used
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.profile
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.profile

# Set a var with the latest stable Python versions...we'll use this multiple times (inspired by https://stackoverflow.com/questions/29687140/install-latest-python-version-with-pyenv)
# Using full(er) path here because we haven't bothered to put pyenv in path
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
# Install Symlinks                                             #
################################################################

echo "######### Install Symlinks #########"

ln -s /mnt/c/Users/bill.deitrick/Documents ~/Documents
