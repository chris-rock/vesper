#!/bin/bash
# run via: ncat -lk -p 8081 --sh-exec ./examples/json.sh

source "vesper.sh"

# generate the response
function handle_json {
  BUCKET_NAME="blob_bucket"
  OBJECT_NAME="blob_object"
  JSON_FMT='{"bucketname":"%s","objectname":"%s"}\n'

  http_response StatusOK "application/json"
  printf "$JSON_FMT" "$BUCKET_NAME" "$OBJECT_NAME"
}

handle_json