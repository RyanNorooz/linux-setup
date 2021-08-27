#!/bin/bash

echo
echo "wassssuuuuup....!"
echo "script will install basic tools and setupup configs for the new user."
read $REPLY -p "sounds good? [y/n] "

if [[ $REPLY =~ ^[Nn]$ ]]; then
    echo "exiting..."
    exit 1
fi


# install stuff
echo; echo "Installing packages..."
apt install -y git tmux nodejs npm fonts-powerline
npm -g install pnpm

echo; echo "Conjuring Zsh magic..."
apt install -y zsh
chsh -s $(which zsh) # set zsh as default shell
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" # OhMyZsh


# config stuff
echo; echo "Configuring stuff..."
cat .zshrc >> ~/.zshrc
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
cp .tmux.conf ~/.tmux.conf
cp .nanorc ~/.nanorc

git config --global user.name "Ryan Norooz"
git config --global user.email "58340667+RyanNorooz@users.noreply.github.com"
git config --global user.username "RyanNorooz"
git config --global core.editor "nano"


echo; echo "Done!"
echo "its a good idea to restart your system now..."
