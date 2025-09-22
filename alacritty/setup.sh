#!/bin/bash

sudo apt install alacritty
sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/bin/alacritty 50
#sudo update-alternatives --config x-terminal-emulator  # This one needs a manual input "manual mode"
sudo update-alternatives --set x-terminal-emulator /usr/bin/alacritty

# Config file
mkdir -p ~/.config/alacritty
current_dir=$PWD
pushd ~/.config/alacritty
ln -s $PWD/alacritty.toml
