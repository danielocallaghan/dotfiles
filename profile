# Source global definitions
 if [ -f /etc/bashrc ]; then
   . /etc/bashrc
 fi
# Source private vars
if [ -f ~/Dropbox/workrelated/private-env.bash ]; then
  . ~/Dropbox/workrelated/private-env.bash
fi

[[ -r $rvm_path/scripts/completion ]] && . $rvm_path/scripts/completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

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
alias gap='git add -p'
alias gd='git diff'
alias gds='git diff --staged'
alias gri2='git stash; git rebase -i HEAD~2; git stash pop'
alias gpushmefeature='git commit; git push me `current_git_branch`;'
alias gupfrommaster='br=`current_git_branch`;git stash; git co master; git pull; git co $br; git rebase master; git push -f me $br;git stash show -p;'
alias gcommitandopenpr='git commit;git push me $current_git_branch;hub pull-request'

alias be='bundle exec'
alias ber='bundle exec rake'
alias bes='bundle exec spec'
alias bers='bundle exec rspec'
alias bes='bundle exec rspec'
alias bec='bundle exec cucumber'
alias rcur='bundle exec cucumber --tags @cur'

alias deployccodev='git push dev && heroku run rake db:migrate --app cco-io-dev && heroku ps:restart --app cco-io-dev'
alias deployccouat='git push uat && heroku run rake db:migrate --app cco-io-uat && heroku ps:restart --app cco-io-uat'
alias deployccoprod='git push prod && heroku run rake db:migrate --app cco-io-prod && heroku ps:restart --app cco-io-prod'

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
export HISTFILESIZE=100000000
export HISTSIZE=100000000
export HISTCONTROL=ignoredups:erasedups
export HISTIGNORE="&:[ ]*:exit"
## Save the history after each command finishes
### (and keep any existing PROMPT_COMMAND settings)
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
export PT_TOKEN="241684b37391333e81db2df64265652d"

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

run_byebugger ()
{
  while :
  do
    be byebug -R localhost:12345
  done
}

run_pryremote ()
{
  while :
  do
    pry-remote
    sleep 1
  done
}

# usage eg: storyNames 108986798 108977884 108364434
function storyNames {
  PROJECT_ID="1340646"
  declare -a story_ids="$@"
  for STORY_ID in $story_ids; do
    story=$(curl -s -X GET -H "X-TrackerToken: $PT_TOKEN" "https://www.pivotaltracker.com/services/v5/projects/$PROJECT_ID/stories/$STORY_ID")
    IFS=$'\n'
    declare -a names=($(echo $story | json_pp | awk '/"name"/ { print $0 }'))
    echo $story | json_pp | awk '/"url"/ { print $0 }' | awk -F"\" : \"" '{ print $2 }' | sed 's/",//'
    echo $story | json_pp | awk '/"kind"/ { print $0 }' | awk -F"\" : \"" '{ print $2 }' | sed 's/",//'
      for name in ${names[@]}; do
        echo $name | awk -F"\" : \"" '{ print $2 }' | sed 's/",//'
      done
    echo
  done
}

PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\[$(branch_color)\]\n$(parse_git_branch)\[${c_sgr0}\]\n\$ '

export GOPATH=$HOME/Sites/cco

export NVM_DIR="$HOME/.nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && . "$NVM_DIR/nvm.sh" # This loads nvm

### Added by the Heroku Toolbelt
PATH=$PATH:/usr/pgsql-9.1/bin:$HOME/.rvm/bin # Add RVM to PATH for scripting
export PATH=$PATH:/usr/local/opt/go/libexec/bin
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:/usr/local/bin
export PATH=$PATH:/usr/local/sbin
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"  # This loads RVM
source ~/.git-completion.bash
