# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi
# Source private vars
if [ -f ~/.private-env.bash ]; then
  . ~/.private-env.bash
fi

# User specific aliases and functions
export PATH=/usr/local/bin:$PATH

alias l='ls -al'
alias vim="stty stop '' -ixoff ; vim"
alias gitcycle='git stash && git pull --rebase && git stash pop'
alias gs='git status .'
alias be='bundle exec'
alias ber='bundle exec rake'
alias bes='bundle exec spec'
alias bers='bundle exec rspec'
alias rails='bundle exec rails'
alias sshec2='ssh -v -i ~/.ssh/s3-proxy-keypair.pem ubuntu@ec2-23-22-201-235.compute-1.amazonaws.com'

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"  # This loads RVM
[[ -r $rvm_path/scripts/completion ]] && . $rvm_path/scripts/completion

# GIT modifications
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi
if [ -f /usr/share/git-core/git-completion.bash ]; then
  . /usr/share/git-core/git-completion.bash
fi
export CLICOLOR=1
export TERM=xterm-color
export LSCOLORS=GxFxCxDxBxegedabagaced
export VISUAL=vim
export EDITOR=vim

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

PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\[$(branch_color)\]\n$(parse_git_branch)\[${c_sgr0}\]\$ '

### Added by the Heroku Toolbelt
PATH=$PATH:/usr/pgsql-9.1/bin:$HOME/.rvm/bin # Add RVM to PATH for scripting
