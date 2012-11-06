export EC2_HOME="/Users/danieloc/Documents/AWS/ec2-api-tools-1.3-24159"
export EC2_PRIVATE_KEY="~/.ec2/pk-PON566DBRY3RZB352UK4ZSPN56DYFYNA.pem"
export AWS_SECRET_KEY="5MK6nbFCRtBqALFqUItZNtl3JXRqwfa6lfiEPMJF"
export EC2_CERT="~/.ec2/cert-PON566DBRY3RZB352UK4ZSPN56DYFYNA.pem"
export JAVA_HOME="/System/Library/Frameworks/JavaVM.framework/Versions/1.5.0/Home"

#export PATH=~/.gem/ruby/1.8/bin:/usr/local/git/bin:/usr/local/mysql/bin:$PATH
export PATH=/usr/local/bin:$PATH

export ARCHFLAGS="-arch i386 -arch x86_64"
export EVENT_NOKQUEUE=1
export MANPATH=/usr/local/git/man:$MANPATH

alias l='ls -al'
alias sites='cd /Users/danieloc/Sites/rails_apps/heroku/'
alias show_processlist='while true; do x=`echo "show processlist;"| mysql -ualtnet -p3wumexEgeP -h127.0.0.1 altnet|grep -v Sleep `; echo $x; echo $x|wc -l; echo " unslept processes"; sleep 5; done'
alias gitcycle='git stash && git pull --rebase && git stash pop'
alias getherokubackup='curl -o ~/Downloads/database_backups/backup-`date +%d-%m-%Y`.dump `heroku pgbackups:url`'
alias herokuimport='pg_restore --verbose --clean --no-acl --no-owner -h localhost -p 5434 -U rails_app -d dms_dev2 backup-01-04-2012.dump'
alias be='bundle exec'
alias ber='bundle exec rake'
alias rails='bundle exec rails'
alias sshec2='ssh -v -i ~/.ssh/s3-proxy-keypair.pem ubuntu@ec2-23-22-201-235.compute-1.amazonaws.com'

# alias mysql=/usr/local/mysql/bin/mysql
# alias mysqladmin=/usr/local/mysql/bin/mysqladmin

if [[ -s /Users/danieloc/.rvm/scripts/rvm ]] ; then source /Users/danieloc/.rvm/scripts/rvm ; fi
complete -C $rvm_scripts_path/rvm-completion.rb -o default rvm
# source ~/bin/git-completion.bash

# GIT modifications
export CLICOLOR=1
export TERM=xterm-color
export LSCOLORS=GxFxCxDxBxegedabagaced

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

PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\[$(branch_color)\]$(parse_git_branch)\[${c_sgr0}\]\$ '

alias gs='git status .'

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
