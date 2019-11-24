#!/bin/bash
# run via: ncat -lk -p 8081 --sh-exec ./examples/pdf.sh

source "vesper.sh"

function handle_pdf {
  file="rose94.pdf"
  http_response StatusOK "application/pdf"
  cat ${file} >&1
}

handle_pdf