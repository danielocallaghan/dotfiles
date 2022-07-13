alias be='bundle exec'
alias bes='bundle exec rspec'

alias k=kubectl
alias docker-rm='docker rm $(docker ps -a -q -f status=exited)'
alias docker-rmi='docker rmi $(docker images -q -f dangling=true)'
alias docker-rmv='docker volume rm $(docker volume ls -q -f dangling=true)'

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

