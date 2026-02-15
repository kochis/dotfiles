#!/bin/bash
echo 'Symlinking dotfiles'

# root files
ln -s ~/.dotfiles/ackrc ~/.ackrc
ln -s ~/.dotfiles/bash_profile ~/.bash_profile
ln -s ~/.dotfiles/ctags.cnf ~/.ctags.cnf
ln -s ~/.dotfiles/gemrc ~/.gemrc
ln -s ~/.dotfiles/gitconfig ~/.gitconfig
ln -s ~/.dotfiles/gitignore_global ~/.gitignore_global
ln -s ~/.dotfiles/git-prompt.sh ~/.git-prompt.sh
ln -s ~/.dotfiles/tmux.conf ~/.tmux.conf

# ~/.config setup
mkdir -p ~/.config
ln -s ~/.dotfiles/config/nvim ~/.config/nvim

./check_shell.sh
./install_apps.sh

echo '!!! Dont forget to update .gitconfig !!!'
echo 'NOTE: brew install reattach-to-user-namespace if tmux wont start'
