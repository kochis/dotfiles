#!/bin/bash
# Core packages needed by the tmux / neovim / bash config in this repo.
# For everything installed on the reference machine, use: brew bundle --file=Brewfile
set -e

brew install \
  ack \
  autojump \
  bash-completion \
  ctags \
  direnv \
  fzf \
  git \
  jq \
  n \
  neovim \
  ripgrep \
  tmux

# Java: openjdk (21+) runs the jdtls language server; openjdk@17 is the
# default project runtime (JAVA_HOME in bash_profile).
brew install openjdk openjdk@17

# Nerd Font for nvim-web-devicons / render-markdown icons
brew install --cask font-jetbrains-mono-nerd-font
