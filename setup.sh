#!/bin/bash

# ================= activate sudo mode =================
if [ "$EUID" != 0 ]; then
    sudo "$0" "$@"
    exit $?
fi


# ======================= welcome =======================
echo
echo "wassssuuuuup....!"
echo "script will install basic tools and setupup configs for the new user."
echo
read $REPLY -p "sounds good? [y/n] "
echo

if [[ $REPLY =~ ^[Nn]$ ]]; then
    echo "exiting..."
    exit 1
fi


# ==================== install stuff ====================
echo
echo "Installing packages..."
echo
apt update -y
apt install -y git tmux nodejs npm fonts-powerline zsh
npm i -g pnpm


# ======================= OhMyZsh =======================
echo
echo "Conjuring Zsh magic..."
echo
CHSH=yes
RUNZSH=no
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


# ================ download config files ================
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
git clone https://github.com/RyanNorooz/dotfiles ~/.dotfiles.tmp


# ===================== config stuff =====================
echo
echo "Configuring stuff..."
echo
cp ~/.dotfiles.tmp/.tmux.conf ~/.tmux.conf
cp ~/.dotfiles.tmp/.nanorc ~/.nanorc
cp ~/.dotfiles.tmp/.gitconfig ~/.gitconfig

cat .zshrc >> ~/.zshrc # append to zshrc


# ======================= cleanup =======================
echo
echo "Cleaning up..."
echo
rm -r ~/.dotfiles.tmp
apt autoremove -y
apt autoclean -y


# ======================= goodbye =======================
echo
echo "=================== Done! ==================="
echo "its a good idea to restart your system now..."
echo "============================================="
echo

exit 0
