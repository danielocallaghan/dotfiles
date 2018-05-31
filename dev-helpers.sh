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

trigger_throttling() {
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
  echo "$@" &> /dev/stdout
  curl -H 'Content-Type: application/json' -s -i "$@" &> /dev/stdout | pygmentize -l json | less -r
}
export -f jcurl

local_indexes() {
  curl -s 'localhost:9200/_cat/indices?v' | grep 'index'
}
export -f local_indexes

browse_index() {
  jcurl -XPOST "localhost:9200/$1/_search?pretty"  -d '
    {
      "query": { "match_all": {} },
      "size": 3
    }'
}
export -f browse_index

