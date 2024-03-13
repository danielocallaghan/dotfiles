alias be='bundle exec'
alias bes='bundle exec rspec'

alias k=kubectl
alias kc=kubectl
alias klocal='kubectl --context=minikube'
alias kdev='kubectl --context=dev'
alias kprod='kubectl --context=prod'
alias kstage='kubectl --context=stage'
alias kt='kubectl --context=tools'
alias ktd='kubectl --context=tools-dev'
alias ktdep='kubectl --context=tools -n dependabot'

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
alias gri2='git stash; git rebase -i HEAD~2; git stash pop'
alias gupfrommaster='br=`current_git_branch`;git stash; git co master; git pull; git co $br; git rebase master;'
alias pc='perctl'
alias mc='./monolith-cli'
alias flag-janitor='~/dev/flag-janitor/flag-janitor'
alias pcreload="pc refresh && pc artisan personio:i18n-json && per && rm -rf node_modules && yarn install --pure-lockfile && yarn run start"
alias pcreload-mysql="pc build dev && pc recreate mysql && pc recreate web"
alias pclaravel-log="tail -f ~/dev/personio/app/storage-local/logs/laravel.log"
alias pcstorage-777="sudo chmod -R 777 app/storage-local/ && sudo chmod -R 777 app/storage"
alias docker-rm='docker rm $(docker ps -a -q -f status=exited)'
alias docker-rmi='docker rmi $(docker images -q -f dangling=true)'
alias docker-rmv='docker volume rm $(docker volume ls -q -f dangling=true)'
alias gr="./gradlew"
alias gr-debug="./gradlew --no-daemon --no-build-cache -Dorg.gradle.jvmargs='-Xdebug -Xrunjdwp:transport=dt_socket,server=y,address=5005,suspend=y'"

function jcurl() {
  # echo "$@" &> /dev/stdout
  curl -H 'Content-Type: application/json' -s -i "$@" &> /dev/stdout | pygmentize -l json
}

function local_indexes() {
  curl -s 'localhost:9200/_cat/indices?v' | grep 'index'
}

function browse_index() {
  jcurl -XPOST "localhost:9200/$1/_search?pretty"  -d '
    {
      "query": { "match_all": {} },
      "size": 3
    }'
}

aws-console ()
{
    profile=$1
    login_uri=$(aws-vault login ${profile} -s)
    osascript \
      -e 'tell application "Google Chrome"' \
      -e 'activate' \
      -e 'open location "https://signin.aws.amazon.com/oauth?Action=logout&redirect_uri=aws.amazon.com"' \
      -e 'delay 1' \
      -e 'close active tab of window 1' \
      -e "open location \"${login_uri}\"" \
      -e 'end tell'
}

for profile in master dev stage prod e2etest office gitlab bi tools tools-dev backup backup-dev office-it; do
  alias aws-console-${profile}="aws-console ${profile}"
  alias aws-login-${profile}="AWS_PROFILE=${profile} aws sso login"
done

test-result() {
  command find $1 -name "index.html" -exec open {} \;
}

ktlint-result() {
  command cat "build/reports/ktlint/ktlintMainSourceSetFormat/ktlintMainSourceSetFormat.txt"
  command cat "build/reports/ktlint/ktlintTestSourceSetFormat/ktlintTestSourceSetFormat.txt"
  command cat "build/reports/ktlint/ktlintMainSourceSetCheck/ktlintMainSourceSetCheck.txt"
  command cat "build/reports/ktlint/ktlintKotlinScriptCheck/ktlintKotlinScriptCheck.txt"
}
