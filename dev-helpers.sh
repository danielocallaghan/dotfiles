alias be='bundle exec'
alias ber='bundle exec rake'
alias bes='bundle exec rspec'
alias bec='bundle exec cucumber'
alias rcur='bundle exec cucumber --tags @cur'
alias srspec='spring rspec'
alias srs='spring rspec'
alias srails='spring rails'
alias srake='spring rake'
alias dea='docker exec -it airtasker_app_1'
alias dep='docker exec -it airtasker_postgres_1'

alias docker-rm='docker rm $(docker ps -a -q -f status=exited)'
alias docker-rmi='docker rmi $(docker images -q -f dangling=true)'
alias docker-rmv='docker volume rm $(docker volume ls -q -f dangling=true)'

alias devapimore='git --no-pager log --pretty=oneline `curl -s https://api.dev.airtasker.com/gitref` | head -n 200 | less'
alias stgapimore='git --no-pager log --pretty=oneline `curl -s https://api.stage.airtasker.com/gitref` | head -n 200 | less'
alias prodapimore='git --no-pager log --pretty=oneline `curl -s https://api.airtasker.com/gitref` | head -n 200 | less'

function trigger_throttling() {
  echo "Sending 100 requests..."

  for i in {1..100}
  do
    echo ""
    curl http://localhost:3000/$1
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
