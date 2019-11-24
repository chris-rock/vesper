#!/bin/bash
# run via: ncat -lk -p 8081 --sh-exec ./examples/helloworld.sh

source "vesper.sh"

# parses the http request
http_request

# generate the response
function handle_text {
  http_response StatusOK "text/plain"
  echo 'Hello World'
  echo $HTTP_REQUEST_URI
}

handle_text