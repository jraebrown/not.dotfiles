# zsh configuration file
#
# Author: JRB
# Date:   Sat Oct 30th 2021

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#ZSH_THEME="powerlevel10k/powerlevel10k"

# Add local sbin to $PATH.
export PATH="/usr/local/sbin:$HOME/crwctl/bin:${PATH}"

# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.dotfiles/oh-my-zsh

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

# Set to this to use case-sensitive completion
export CASE_SENSITIVE="true"

# Define how often to auto-update (in days).
export UPDATE_ZSH_DAYS=7

# disable weekly auto-update checks
# export DISABLE_AUTO_UPDATE="true"
# Enable command auto-correction.
ENABLE_CORRECTION="false"

# Display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# disable colors in ls
# export DISABLE_LS_COLORS="true"

# disable autosetting terminal title.
export DISABLE_AUTO_TITLE="true"


# Configure history stamp format
HIST_STAMPS="dd-mm-yyyy"

#Auto CD
setopt AUTO_CD

# Magic Enter Plugin settings
MAGIC_ENTER_GIT_COMMAND='git status -u . && la'
MAGIC_ENTER_OTHER_COMMAND='la'

# Which plugins would you like to load? (plugins can be found in ~/.dotfiles/oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(
  colorize
  compleat
  dirpersist
  gulp
  history
  cp
  colored-man-pages
  nmap
  iterm2
  brew
  colored-man-pages
  colorize
  git
  pip
  python
  nmap
  osx
  iterm2
  autojump
  z
  magic-enter
  zsh-navigation-tools
  zsh-interactive-cd
  autojump
  history-substring-search
  you-should-use
)

# Load oh-my-zsh framework
source "${ZSH}/oh-my-zsh.sh"

CONFIG_DIR=~/.dotfiles/

alias config='nocorrect config'

# Load shell dotfiles
source ${CONFIG_DIR}/.aliases

#source /usr/local/opt/nvm/nvm.sh --no-use

autoload -U add-zsh-hook
load-nvmrc() {
  if [[ -f .nvmrc && -r .nvmrc ]]; then
    nvm use &> /dev/null
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

# Customize to your needs...
unsetopt correct

# run fortune on new terminal :)
# fortune

#eval "$(starship init zsh)"


if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

  autoload -Uz compinit
  compinit
fi
source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

fixZsh() {
	for f in $(compaudit)
	do 
		sudo chown -R $(whoami):root $f
		sudo chmod -R 755 $f
	done
}

neofetch

SPACESHIP_GIT_BRANCH_SHOW="false"

code () { VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $* ;}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
