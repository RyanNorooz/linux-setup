#!/bin/bash

# update stuff
apt update
apt upgrade -y
apt autoremove -y
apt autoclean -y


# Zsh
apt install -y zsh
chsh -s $(which zsh) # set zsh as default shell
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" # OhMyZsh


# install stuff
apt install -y zsh tmux git node fonts-powerline


# config stuff
cat .zshrc >> ~/.zshrc
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
cp .tmux.conf ~/.tmux.conf
cp .nanorc ~/.nanorc

git config --global user.name "Ryan Norooz"
git config --global user.email "58340667+RyanNorooz@users.noreply.github.com"
git config --global user.username "RyanNorooz"
git config --global core.editor "nano"
