source ~/.git-prompt.sh

export PATH="/opt/homebrew/opt/openjdk/bin:/opt/homebrew/bin:/opt/homebrew/opt/ruby/bin:/opt/homebrew/lib/ruby/gems/3.1.0/bin:/Users/craig/development/flutter/bin:$PATH"

if [[ `uname` == Darwin ]]; then
  if [ -f `brew --prefix autojump`/etc/autojump ]; then
      source `brew --prefix autojump`/etc/autojump
  fi

  if [ -f `brew --prefix`/etc/bash_completion ]; then
      source `brew --prefix`/etc/bash_completion
  fi

  if [ -f `brew --prefix git-flow`/etc/bash_completion.d/git-flow-completion.bash  ]; then
      source `brew --prefix git-flow`/etc/bash_completion.d/git-flow-completion.bash
  fi

  [[ -r "$HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh" ]] && . "$HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh"

  for COMPLETION in "${HOMEBREW_PREFIX}/share/bash-completion/completions/"*
  do
    [[ -r "${COMPLETION}" ]] && source "${COMPLETION}"
  done
fi

if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
    source /usr/local/bin/virtualenvwrapper.sh
  elif [ -f /usr/local/share/python/virtualenvwrapper.sh ]; then
    source /usr/local/share/python/virtualenvwrapper.sh
fi

export FZF_DEFAULT_COMMAND='rg --files'

[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh

# colors
COLOR_NONE='\[\033[0m\]'
COLOR_BOLD='\[\033[1m\]'
COLOR_UNDER='\[\033[4m\]'

COLOR_BLACK='\[\033[30m\]'
COLOR_RED='\[\033[31m\]'
COLOR_GREEN='\[\033[32m\]'
COLOR_YELLOW='\[\033[33m\]'
COLOR_BLUE='\[\033[34m\]'
COLOR_MAGENTA='\[\033[35m\]'
COLOR_CYAN='\[\033[36m\]'
COLOR_WHITE='\[\033[37m\]'

COLOR_BLACK_BG='\[\033[40m\]'
COLOR_RED_BG='\[\033[41m\]'
COLOR_GREEN_BG='\[\033[42m\]'
COLOR_YELLOW_BG='\[\033[43m\]'
COLOR_BLUE_BG='\[\033[44m\]'
COLOR_MAGENTA_BG='\[\033[45m\]'
COLOR_CYAN_BG='\[\033[46m\]'
COLOR_WHITE_BG='\[\033[47m\]'

# git prompt goodnes
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWUPSTREAM=verbose
PS1="${COLOR_RED}[${COLOR_WHITE}\t ${COLOR_NONE}\W${COLOR_GREEN}\$(__git_ps1 ' (%s)')${COLOR_RED}]${COLOR_NONE}\$ "

# some more ls aliases
alias ls='ls -G'
alias ll='ls -Al'
alias mkdir='mkdir -p'
alias which='type -a'
alias ..='cd ..'
alias cl='clear'
alias du='du -kh'
alias df='df -kTh'

alias r='bundle exec rails'
alias b='bundle exec'
alias c='bundle exec cap'
alias f='git flow feature'
alias release='git flow release'
alias rk='b rake'
alias mig='b rake db:migrate db:test:prepare'

alias start_pow="launchctl load $HOME/Library/LaunchAgents/cx.pow.powd.plist"
alias stop_pow="launchctl unload $HOME/Library/LaunchAgents/cx.pow.powd.plist"

# use Vim commands
set -o vi

# Erase duplicates in history
export HISTCONTROL=erasedups
# Store 10k history entries
export HISTSIZE=10000
# Append to the history file when exiting instead of overwriting it
shopt -s histappend

alias be='bundle exec'
alias gb='git branch --sort=-committerdate'
alias gf='git fetch'
alias gm='git merge'
alias gmom='git merge origin/master'
alias grom='git rebase origin/master'
alias grc='git rebase --continue'
alias grpo='git remote prune origin'
alias gru="git remote show | sed '/heroku/d' | xargs -I {} git remote update {} --prune; git submodule update"
alias gs="git status"
alias gdc="git diff --cached"
alias glx='git log --graph --all --decorate --pretty=format:"%C(magenta)%h %C(blue)%ai %C(green)%an %C(cyan)%s %C(yellow bold)%d"'
alias glxx='git log --graph --all --decorate'
alias hglog='hg sglog | less -R'
alias tmux='tmux -2'


function __current_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

function __current_branch_action {
  echo  "git $1`git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`"
  eval  "git $1`git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`"
}

function gmox {
  __current_branch_action "merge origin/"
}

function grox {
  __current_branch_action "rebase origin/"
}

function gpox {
  __current_branch_action "push origin "
}

function awklog {
  echo "awk ' /^$/ {flag=0} /Started.+$2/ {flag=1} flag { print }' $1"
  eval "awk ' /^$/ {flag=0} /Started.+$2/ {flag=1} flag { print }' $1"
}

function pgrep () {
  ps aux | grep $1 | grep -v 'grep'
}

function pkill () {
  kill -9 $(ps -Ao pid,comm | grep $1 | grep -v 'grep' | awk '{print $1'}) 2>&1
}


function generate-tags() {
  # use the ctags installed from homebrew
  /opt/homebrew/bin/ctags -R -V --options=$HOME/.ctags.cnf
}

function rebase-master {
  (git checkout master || git checkout main) && git fetch && git rebase
}

function docker-clean {
  docker system prune --all --volumes;
  docker volume ls -q | xargs docker volume rm
}

function awsv () {
  aws-vault exec ProductionEngineer -- aws "$@"
}

# brew install ffmpeg gifsicle
function mov-to-gif {
  name=`basename $1 .mov`
  ffmpeg -i "$name.mov" -pix_fmt rgb8 -r 10 "$name.gif" && gifsicle -O3 "$name.gif" -o "$name.gif"
}

function add-shadow {
  convert "$1" \( +clone -background black -shadow 50x10+5+5 \) +swap -background none -layers merge +repage "$1"
}

alias vim=nvim
export EDITOR=nvim

if [ -f ~/.env_keys.sh  ]; then
    source ~/.env_keys.sh
fi

export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).

# jenv
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

# coursier (Scala) install directory
export PATH="$PATH:/Users/craig/Library/Application Support/Coursier/bin"

# homebrew sbin
export PATH="/opt/homebrew/sbin:$PATH"

# bin and coreutils
export PATH="/opt/homebrew/opt/binutils/bin:$PATH"
export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"

export PKG_CONFIG_PATH=/opt/homebrew/opt/openssl@3.3/lib/pkgconfig/

export LANG=en_US.UTF-8

. "$HOME/.cargo/env"
