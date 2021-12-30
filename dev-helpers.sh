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

alias devapimore='git --no-pager log --pretty=oneline `curl -s https://api.dev.airtasker.com/gitref` | head -n 200 | less'
alias stgapimore='git --no-pager log --pretty=oneline `curl -s https://api.stage.airtasker.com/gitref` | head -n 200 | less'
alias prodapimore='git --no-pager log --pretty=oneline `curl -s https://api.airtasker.com/gitref` | head -n 200 | less'

# <region><environment>logs <namespace> <include_regex> <any_stern_inputs>
# Show me the bff-client pods logs in the api namespace.
# audevlogs api bff-client
# Show me the recommender logs in the data namespace but exclude healthchecks
# ukprodlogs data recommender -e healthcheck
export audevkc=/Users/$(whoami)/.kube/k8s.dev.airtasker.com-config
export austagekc=/Users/$(whoami)/.kube/k8s.stage.airtasker.com-config
export auprodkc=/Users/$(whoami)/.kube/k8s.airtasker.com-config
export ukdevkc=/Users/$(whoami)/.kube/k8s.dev.airtasker.co.uk-config
export ukstagekc=/Users/$(whoami)/.kube/k8s.stage.airtasker.co.uk-config
export ukprodkc=/Users/$(whoami)/.kube/k8s.airtasker.co.uk-config
alias audevlogs="stern --kubeconfig=$audevkc -n $*"
alias austagelogs="stern --kubeconfig=$austagekc -n $*"
alias auprodlogs="stern --kubeconfig=$auprodkc -n $*"
alias ukdevlogs="stern --kubeconfig=$ukdevkc -n $*"
alias ukstagelogs="stern --kubeconfig=$ukstagekc -n $*"
alias ukprodlogs="stern --kubeconfig=$ukprodkc -n $*"


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
