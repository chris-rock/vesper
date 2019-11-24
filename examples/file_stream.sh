#!/bin/bash
# run via: ncat -lk -p 8081 --sh-exec ./examples/file_stream.sh

source "vesper.sh"

function handle_file_stream() {
  http_response StatusOK "application/pdf"
  wkhtmltopdf --quiet "http://tiswww.case.edu/php/chet/bash/bashtop.html" - >&1
}

handle_file_stream