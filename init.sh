#!/bin/bash

sudo apt-get install git
# Generate SSH key
ssh-keygen -t rsa -b 4096 -C "$EMAIL"
# Pause to pick a password for the key

ssh-add ~/.ssh/id_rsa
git config --global user.email "$EMAIL"
git config --global user.name "$NAME"
# Pause here to add public key to github, to pull down dotfiles repo

mkdir scripts
mkdir Development
cd Development
git clone git@github.com:aarose/dotfiles.git
cd dotfiles
cp .vimrc ~/.vimrc
sudo apt-get install vim-gui-common  # if vim version has "Small version without GUI."
sudo apt-get install vim-runtime # recommended to also have
sudo apt-get install curl  # required for Vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
# run :PluginInstall in vim to get Vundle installing all the vimrc stuff

sudo apt-get install build-essential cmake  # needed to compile YouCompleteMe
sudo apt-get install python-dev  # needed to compile YouCompleteMe
cd ~/.vim/bundle/YouCompleteMe
./install.py --clang-completer --gocode-completer # both C and Go included

sudo apt-get install python-pip
cd ~/Development/dotfiles
sudo pip install -r requirements.txt

cp .bashrc ~/.bashrc
source ~/.bashrc  # will have to give SSH pass key
