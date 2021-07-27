#!/bin/bash
echo 'Symlinking dotfiles'

ln -s ~/.dotfiles/ackrc ~/.ackrc
ln -s ~/.dotfiles/bash_profile ~/.bash_profile
ln -s ~/.dotfiles/gitconfig ~/.gitconfig
ln -s ~/.dotfiles/gitignore_global ~/.gitignore_global
ln -s ~/.dotfiles/gemrc ~/.gemrc
ln -s ~/.dotfiles/git-prompt.sh ~/.git-prompt.sh
ln -s ~/.dotfiles/tmux.conf ~/.tmux.conf
ln -s ~/.dotfiles/ctags.cnf ~/.ctags.cnf

echo '!!! Dont forget to update .gitconfig !!!'
echo 'NOTE: brew install reattach-to-user-namespace if tmux wont start'

./check_shell.sh
