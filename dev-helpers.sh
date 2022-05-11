alias be='bundle exec'
alias ber='bundle exec rake'
alias bes='bundle exec rspec'
alias bec='bundle exec cucumber'
alias rcur='bundle exec cucumber --tags @cur'
alias srspec='spring rspec'
alias srs='spring rspec'
alias srails='spring rails'
alias srake='spring rake'

alias docker-rm='docker rm $(docker ps -a -q -f status=exited)'
alias docker-rmi='docker rmi $(docker images -q -f dangling=true)'
alias docker-rmv='docker volume rm $(docker volume ls -q -f dangling=true)'

function trigger_throttling() {
  echo "Sending 600 requests..."

  for i in {1..600}
  do
    echo ""
    curl http://localhost:3001/$1
  done

  echo ""
  echo "All subsequent requests should now be throttled until the next app restart."
  echo "View this behaviour by sending another request eg:"
  echo "curl -i http://localhost:3000/$1"
  curl -i http://localhost:3000/$1
  echo ""
}

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

function run_stage_e2e() {
  curl -X POST \
    "https://circleci.com/api/v1.1/project/github/airtasker/web/tree/master?circle-token=$CIRCLECI_TOKEN" \
    -H 'Content-Type: application/json' \
    -d '{
          "build_parameters": {
            "CIRCLE_JOB": "cypress-test-passthrough-stage-electron"
          }
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

testresult () {
  command find $1 -name "index.html" -exec open {} \;
}

