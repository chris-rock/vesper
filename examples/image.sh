#!/bin/bash
# run via: ncat -lk -p 8081 --sh-exec ./examples/image.sh

source "vesper.sh"

function handle_image() {
  http_response StatusOK "image/jpeg"
  echo "James Bond" | convert -font Arial -pointsize 72 -fill white -background black text:- -trim png:- >&1
}

handle_image