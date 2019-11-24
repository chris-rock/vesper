#!/bin/bash
# run via: ncat -lk -p 8081 --sh-exec ./examples/custom.sh

source "vesper.sh"

function handle_file {
  http_sendfile "rose94.pdf"
}

handle_file