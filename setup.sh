#!/bin/bash
echo 'Symlinking dotfiles'

ln -s ~/.dotfiles/ackrc ~/.ackrc
ln -s ~/.dotfiles/bash_profile ~/.bash_profile
ln -s ~/.dotfiles/gitconfig ~/.gitconfig
ln -s ~/.dotfiles/gitignore_global ~/.gitignore_global
ln -s ~/.dotfiles/gemrc ~/.gemrc
ln -s ~/.dotfiles/tmux.conf ~/.tmux.conf

echo '!!! Dont forget to update .gitconfig !!!'
