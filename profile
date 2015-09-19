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

if [ -f /usr/local/git/contrib/completion/git-completion.bash ]; then
  . /usr/local/git/contrib/completion/git-completion.bash
fi

# User specific aliases and functions
export PATH=$PATH:/usr/local/bin

alias l='ls -alhg'
alias ..='cd ..'
alias grep='grep --color=auto'
alias df='df -H'
alias du='du -ch'
alias run_popcorntv='sudo node /Users/daniel/Sites/PopcornTV/atv.js'

alias gs='git status .'
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

# GIT modifications
export CLICOLOR=1
export TERM=xterm-color
export LSCOLORS=GxFxCxDxBxegedabagaced
export VISUAL=vim
export EDITOR=vim
export GITHUB_HOST=github.dbg.westfield.com
export rvmsudo_secure_path=0

# improve bash history
shopt -s histappend
export PROMPT_COMMAND='history -w;'$PROMPT_COMMAND
export HISTFILESIZE=10000000
export HISTSIZE=10000000
export HISTCONTROL=ignoredups
export HISTIGNORE="&:[ ]*:exit"

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
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\[$(branch_color)\]\n$(parse_git_branch)\[${c_sgr0}\]\$ '

### Added by the Heroku Toolbelt
PATH=$PATH:/usr/pgsql-9.1/bin:$HOME/.rvm/bin # Add RVM to PATH for scripting
export PATH=/usr/local/bin:$PATH
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"  # This loads RVM
