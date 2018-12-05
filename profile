# Source global definitions
 if [ -f /etc/bashrc ]; then
   . /etc/bashrc
 fi
# Source private vars
if [ -f ~/Dropbox/workrelated/private-env.bash ]; then
  . ~/Dropbox/workrelated/private-env.bash
fi

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi
if [ -f $(brew --prefix)/etc/bash_completion.d/git-completion.bash ]; then
  . $(brew --prefix)/etc/bash_completion.d/git-completion.bash
fi

export AIRTASKER_HOMEDIR=$HOME/Sites/airtasker
export DEPLOYMENT_UTILS_DIR=$AIRTASKER_HOMEDIR/deployment-utilities
export API_DIR=$AIRTASKER_HOMEDIR/api
source $DEPLOYMENT_UTILS_DIR/airtasker.rc
# Disable S3 lookup for maintenance mode in Airtasker Web
export DISABLE_MAINTENANCE_MODE_CHECKS=true
# Disable S3 lookup for heavy tasks in Airtasker Web
export DISABLE_HEAVY_TASKS_CHECKS=true

if [ -f ~/Sites/airtasker/deployment-utilities/airtasker.rc ]; then
  . ~/Sites/airtasker/deployment-utilities/airtasker.rc
fi

getami() { ~/Airtasker/deployment-utilities/bg_deploy/available.sh $1; }
deploy() { ~/Airtasker/deployment-utilities/bg_deploy/bg_deploy.sh $1 $2 $3; }
restartNode() { ~/Airtasker/deployment-utilities/restart_node.sh $1 $2; }

# User specific aliases and functions
export PATH=$PATH:/usr/local/bin

alias l='ls -lah'
alias ..='cd ..'
alias grep='grep --color=auto'
alias df='df -H'
alias du='du -ch'

alias gs='git status .'
alias gpr='hub pull-request'
alias gc='git commit'
alias gb='git freshness'
alias gap='git add -p'
alias glp='git log -p'
alias gd='git diff'
alias gds='git diff --staged'
alias gri2='git stash; git rebase -i HEAD~2; git stash pop'
alias gpushmefeature='git commit; git push me `current_git_branch`;'
alias gupfrommaster='br=`current_git_branch`;git stash; git co master; git pull; git co $br; git rebase master; git push -f me $br;git stash show -p;'
alias gcommitandopenpr='git commit;git push me $current_git_branch;hub pull-request'
alias refreshctags='ctags -R --languages=ruby --exclude=.git'
alias stgssh='ssh -o ProxyCommand="ssh staging-bastion nc -w 120 %h %p 2> /dev/null" -l ubuntu -i ~/.ssh/staging/old-airtasker-staging.pem'

# GIT modifications
export CLICOLOR=1
export TERM=xterm-color
export LSCOLORS=GxFxCxDxBxegedabagaced
export VISUAL=vim
export EDITOR=vim
export rvmsudo_secure_path=0

# improve bash history
shopt -s histappend ## append, no clearouts
shopt -s histverify ## edit a recalled history line before executing
shopt -s histreedit ## reedit a history substitution line if it failed
export HISTFILESIZE=1000000000
export HISTSIZE=1000000000
export HISTIGNORE="&:[ ]*:exit"
## Save the history after each command finishes
### (and keep any existing PROMPT_COMMAND settings)
# export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
# insert history on the fly but don't reload - maintains independence between tabs
export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# Setting GIT prompt
c_cyan=`tput setaf 6`
c_red=`tput setaf 1`
c_green=`tput setaf 2`
c_sgr0=`tput sgr0`

branch_color ()
{
    if git rev-parse --git-dir >/dev/null 2>&1
    then
        color=""
        if git diff --quiet 2>/dev/null >&2
        then
            color=${c_green}
        else
            color=${c_red}
        fi
    else
        return 0
    fi
    echo -n $color
}

parse_git_branch ()
{
    if git rev-parse --git-dir >/dev/null 2>&1
    then
        gitver="["$(git branch 2>/dev/null| sed -n '/^\*/s/^\* //p')"]"
    else
        return 0
    fi
    echo -e $gitver
}

current_git_branch ()
{
  git rev-parse --abbrev-ref HEAD
}

PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\[$(branch_color)\]\n$(parse_git_branch)\[${c_sgr0}\]\n\$ '

export GOPATH=$HOME/golang
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

export MYSQL_PATH=/usr/local/Cellar/mysql/5.7.15
export PATH=$PATH:$MYSQL_PATH/bin

export NVM_DIR="$HOME/.nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && . "$NVM_DIR/nvm.sh" # This loads nvm

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

### Added by the Heroku Toolbelt
export PATH=$PATH:/usr/pgsql-9.1/bin
export PATH=$PATH:/usr/local/bin
export PATH=$PATH:/usr/local/sbin

export PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"  # This loads RVM

source ~/dotfiles/dev-helpers.sh

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
export AIR_HOME=/Users/daniel/Airtasker/web
