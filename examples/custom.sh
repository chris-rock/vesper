#!/bin/bash
# run via: ncat -lk -p 8081 --sh-exec ./examples/custom.sh

source "vesper.sh"

function custom {
  file="rose94.pdf"
  http_message StatusOK
  http_add_header "Server" "vesper"
  http_set_content_type $(file_mime $file)
  http_set_content_length $(file_size $file)
  http_message_body
  cat ${file} >&1
}

custom