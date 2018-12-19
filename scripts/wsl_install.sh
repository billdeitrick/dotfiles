#!/bin/bash

# Stand up tools and apps for Bill's WSL setup

################################################################
# Update Packages Indexes and install Upgrades                 #
################################################################

echo "######### Update Packages Indexes and install Upgrades #########"

sudo apt-get update
sudo apt-get upgrade -y
