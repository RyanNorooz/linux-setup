#!/bin/bash

current_user=$(whoami)

# =================== welcome & notice ===================
echo
echo "User: $current_user"
echo
echo "wassssuuuuup....!"
echo "script will install basic tools and configs apps for the current user: $current_user"
echo
read $REPLY -p "sounds good? [y/n] "
echo

if [[ $REPLY =~ ^[Nn]$ ]]; then
    echo "exiting..."
    exit 1
fi


# ===================== install stuff =====================
echo
echo "Installing packages..."
echo
sudo apt update -y
sudo apt install -y git tmux nodejs npm fonts-powerline zsh

npm i -g npm@latest
npm i -g pnpm
pnpm i -g pnpm@latest


# ================ download config files ================
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
git clone https://github.com/RyanNorooz/dotfiles ~/.dotfiles.tmp


# ====================== config stuff ======================
echo
echo "Configuring stuff..."
echo
cp ./.dotfiles.tmp/.tmux.conf ~/.tmux.conf
cp ./.dotfiles.tmp/.nanorc ~/.nanorc
cp ./.dotfiles.tmp/.gitconfig ~/.gitconfig


# ======================== cleanup ========================
echo
echo "Cleaning up..."
echo
sudo rm -r ./.dotfiles.tmp
sudo apt autoremove -y
sudo apt autoclean -y


# ======================= OhMyZsh =======================
echo
echo "Installing OhMyZsh for ($currentUser)"
echo
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

zsh_config="
export HOME='/home/$currentUser'

# fix for tmux END/HOME keys not working
export TERM=xterm-256color

# some more ls aliases
alias ll='ls -lF'
alias la='ls -ACF'
alias l='ls -CF'
"
echo $zsh_config >> ~/.zshrc # append to zshrc

# ======================== goodbye ========================
exit 0
