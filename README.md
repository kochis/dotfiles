### Installation

Install the following packages via brew (see `install_apps.sh`)
```
ack
autojump
bash-completion
ctags
fzf
git
jq
n
neovim
python3
reattach-to-user-namespace
ripgrep
ruby
tmux
```

Clone repo and run script

`git clone git@github.com:kochis/dotfiles.git ~/.dotfiles && ~/.dotfiles/setup.sh`

Make sure do update git info in .gitconfig

Install the following global packages for neovim
```
pip3 install pynvim
gem install neovim
npm install -g neovim
```

*Note:* Will need to add the brewed ruby to `$PATH` to override mac-ruby
```
export PATH="/opt/homebrew/opt/ruby/bin:/opt/homebrew/lib/ruby/gems/3.1.0/bin:$PATH"

To install neovim plugins:
```
vim +PlugInstall
```
