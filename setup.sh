#!/bin/bash
# Symlink dotfiles into $HOME. Safe to re-run (links are replaced, not duplicated).
set -e
cd "$(dirname "$0")"
DOTFILES="$(pwd)"

echo "Symlinking dotfiles from $DOTFILES"

# root files
ln -sfn "$DOTFILES/ackrc"            ~/.ackrc
ln -sfn "$DOTFILES/bash_profile"     ~/.bash_profile
ln -sfn "$DOTFILES/ctags.cnf"        ~/.ctags.cnf
ln -sfn "$DOTFILES/gitconfig"        ~/.gitconfig
ln -sfn "$DOTFILES/gitignore_global" ~/.gitignore_global
ln -sfn "$DOTFILES/git-prompt.sh"    ~/.git-prompt.sh
ln -sfn "$DOTFILES/tmux.conf"        ~/.tmux.conf

# ~/.config setup
mkdir -p ~/.config
[ -L ~/.config/nvim ] && rm ~/.config/nvim
ln -sfn "$DOTFILES/config/nvim" ~/.config/nvim

# vim-plug (init.vim also bootstraps this on first launch)
PLUG=~/.local/share/nvim/site/autoload/plug.vim
if [ ! -f "$PLUG" ]; then
  echo "Installing vim-plug"
  curl -fLo "$PLUG" --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

if [ "$1" = "--apps" ]; then
  ./install_apps.sh
fi

./check_shell.sh

cat <<MSG

Next steps:
  1. Install apps (if not done):      ~/.dotfiles/install_apps.sh
  2. Install neovim plugins:          nvim +PlugInstall +qall
     (treesitter parsers and Mason LSP servers install on next launch)
  3. Java LSP (optional):             nvim +'MasonInstall jdtls' +qall
  4. Set iTerm font to "JetBrainsMono Nerd Font Mono"
  5. Update name/email in gitconfig if this is not your machine
MSG
