# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/patrick.ocallaghan/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME=powerlevel10k/powerlevel10k

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(gitfast ruby brew)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
# Source global definitions
 # if [ -f /etc/zshrc ]; then
 #   . /etc/zshrc
 # fi
# Source private vars
if [ -f ~/Dropbox/workrelated/private-env.bash ]; then
  . ~/Dropbox/workrelated/private-env.bash
fi

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

# User specific aliases and functions
export PATH=$PATH:/usr/local/bin

alias l='ls -lah'
alias la="exa -abghl --git --color=automatic"
alias lat="exa -abgh --git --color=automatic --tree --level=2"
# `cat` with beautiful colors. requires: pip install -U Pygments
alias c='pygmentize'
alias search='ag'
alias ..='cd ..'
alias grep='grep --color=auto'
alias df='df -H'
alias du='du -ch'

alias gs='git status .'
alias gpl='git pull'
alias gc='git commit'
alias gcm='git co master'
alias gb='git freshness'
alias gap='git add -p'
alias glp='git log -p'
alias gd='git diff'
alias gds='git diff --staged'
alias gbD='git branch -D'
alias gp="git push"
alias ggpull='git pull origin `current_git_branch`'
alias gpo='git push origin `current_git_branch`'
alias gpfo='git push origin `current_git_branch`'
alias hpr='hub pull-request'
alias gri2='git stash; git rebase -i HEAD~2; git stash pop'
alias gpushmefeature='git commit; git push me `current_git_branch`;'
alias gupfrommaster='br=`current_git_branch`;git stash; git co master; git pull; git co $br; git rebase master; git push -f me $br;git stash show -p;'
alias refreshctags='ctags -R --languages=ruby --exclude=.git'
alias perctl=~/dev/personio/perctl
alias pc='perctl'
alias kc='kubectl'
alias per="cd ~/dev/personio"
alias pcreload="pc refresh && pc artisan personio:i18n-json && per && rm -rf node_modules && yarn install --pure-lockfile && yarn run start"
alias pcreload-mysql="pc build dev && pc recreate mysql && pc recreate web"
alias pclaravel-log="tail -f ~/dev/personio/app/storage-local/logs/laravel.log"
alias pcstorage-777="sudo chmod -R 777 app/storage-local/ && sudo chmod -R 777 app/storage"

export AWS_VAULT_FILE_PASSPHRASE="6EX2eDoPY@i6QKAVa" # Avoid entering a passphrase when using aws-vault
export AWS_VAULT_BACKEND="file" # Use the file backend of aws-vault
export AWS_SESSION_TTL="12h" # Set the session ttl to 12 hours to avoid reentering MFA multiple times a day
export AWS_ASSUME_ROLE_TTL="15m"


# GIT modifications
export CLICOLOR=1
export TERM=xterm-color
export LSCOLORS=GxFxCxDxBxegedabagaced
export EDITOR=vim
export VISUAL=vim
export rvmsudo_secure_path=0

# improve history
HISTSIZE=200000
SAVEHIST=100000

function current_git_branch()
{
  git rev-parse --abbrev-ref HEAD
}

# Elixir
export ERL_AFLAGS="-kernel shell_history enabled"
alias mec="mix ecto.create"
alias mem="mix ecto.migrate"
alias mps="mix phx.server"
alias iexmps="iex -S mix phx.server"
alias iexs="iex -S mix"
alias mpr="mix phx.routes"

export GOENV_ROOT="$HOME/.goenv"
export PATH="$GOENV_ROOT/bin:$PATH"
eval "$(goenv init -)"
export GOPATH=$(go env GOPATH)
export PATH="$GOROOT/bin:$PATH"
export PATH="$PATH:$GOPATH/bin"

export MYSQL_PATH=/usr/local/Cellar/mysql/5.7.15
export PATH=$PATH:$MYSQL_PATH/bin

export ESCRIPTS_PATH=~/.mix/escripts
export PATH=$PATH:$ESCRIPTS_PATH

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH=$PATH:/usr/local/opt/libpq/bin
export PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"  # This loads RVM

source ~/dotfiles/dev-helpers.sh

export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terraform terraform

export PATH="/usr/local/opt/python/libexec/bin:$PATH"
export PATH="$(brew --prefix php@7.3)/bin:$PATH"

[[ /usr/local/bin/kubectl ]] && source <(kubectl completion zsh)
export PATH="/usr/local/opt/mysql-client/bin:$PATH"

export GRADLE_USER_HOME="$HOME/.gradle"
export JAVA_HOME="$HOME/.sdkman/candidates/java/current"
export GPG_TTY=`tty`

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
