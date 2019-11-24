#/bin/sh
source "vesper.sh"

# handler

function handle_pdf {
  file="rose94.pdf"
  http_response StatusOK "application/pdf"
  cat ${file} >&1
}

function handle_json {
  BUCKET_NAME="blob_bucket"
  OBJECT_NAME="blob_object"
  JSON_FMT='{"bucketname":"%s","objectname":"%s"}\n'

  http_response StatusOK "application/json"
  printf "$JSON_FMT" "$BUCKET_NAME" "$OBJECT_NAME"
}

function handle_image() {
  http_response StatusOK "image/jpeg"
  echo "James Bond" | convert -font Arial -pointsize 72 -fill white -background black text:- -trim png:- >&1
}

function handle_text {
  http_response StatusOK "text/plain"
  echo 'Hello World'
  echo $HTTP_REQUEST_URI
}

function handle_file {
  http_sendfile "rose94.pdf"
}

function handle_file_stream() {
  http_response StatusOK "application/pdf"
  wkhtmltopdf --quiet "http://tiswww.case.edu/php/chet/bash/bashtop.html" - >&1
}

# implement http router

http_request

if [[ "$HTTP_REQUEST_URI" =~ "pdf" ]]; then
  handle_pdf
  exit 0
fi

if [[ "$HTTP_REQUEST_URI" =~ "text" ]]; then
  handle_text
  exit 0
fi

if [[ "$HTTP_REQUEST_URI" =~ "json" ]]; then
  handle_json
  exit 0
fi

if [[ "$HTTP_REQUEST_URI" =~ "stream" ]]; then
  handle_file_stream
  exit 0
fi

if [[ "$HTTP_REQUEST_URI" =~ "file" ]]; then
  handle_file
  exit 0
fi

if [[ "$HTTP_REQUEST_URI" =~ "image" ]]; then
  handle_image
  exit 0
fi

css="
body {
  background: rgba(0, 0, 0, 0) linear-gradient(270deg, rgb(110, 69, 226) 0%, rgb(217, 100, 100) 100%) repeat scroll 0% 0%;
  background-repeat: repeat;
  background-size: auto;
  background-repeat: repeat;
  background-size: auto;
  height: 100%;
  font-family: San Francisco, Roboto, sans-serif;
}

h1 {
  font-size: 48px;
  font-weight: bold;
  font-family: 'Poppins';
  line-height: 1.2;
  margin: 20px 0px;
  # color: rgb(255, 255, 255);
}

h2 {
  font-size: 28px;
  font-weight: bold;
  font-family: 'Poppins';
  line-height: 0.8;
  margin: 20px 0px;
  # color: rgb(255, 255, 255);
}

pre {
  width: 400px;
  background: black;
  border-radius: 6px;
}

ul {
  list-style: none;
  padding-left: 0;
}

a {
  color: black;
}
"

if [ "$HTTP_REQUEST_URI" == "/" ]; then
  http_response StatusOK "text/html"
  echo "<html>"
  echo "<head>"
  echo "<link rel='stylesheet' href='//cdn.jsdelivr.net/gh/highlightjs/cdn-release@9.16.2/build/styles/default.min.css'>"
  echo "<script src='//cdn.jsdelivr.net/gh/highlightjs/cdn-release@9.16.2/build/highlight.min.js'></script>"
    echo "<link rel='stylesheet' href='//cdn.jsdelivr.net/gh/highlightjs/cdn-release@9.16.2/build/styles/solarized-dark.min.css'>"
  echo "<link href='https://fonts.googleapis.com/css?family=Poppins:400,700' rel='stylesheet'>"
  echo "<link href='https://fonts.googleapis.com/css?family=Roboto:400,700' rel='stylesheet'>"
  echo "<style>$css</style>"
  echo "</head>"
  echo "<body>"
  echo "<h1>Hello Vesper</h1>"
  echo "<h2>HTTP Framework for Unix Shells</h2>"
 
  echo "<strong>Hello World</strong>"
  # hello world
  example="
  source \"vesper.sh\"\n\n
  # parses the http request
  http_request

  # generate the response
  http_response StatusOK \"text/plain\"
  echo 'Hello World'
  echo \$HTTP_REQUEST_URI
  "
  echo "<pre><code class='bash'>$example</code></pre>"
  echo "<script>hljs.initHighlightingOnLoad();</script>"

  # examples
  echo "<strong>Examples</strong>"
  echo "<ul>"
  echo "<li><a href='./text'>Text</a></li>"
  echo "<li><a href='./json'>JSON</a></li>"
  echo "<li><a href='./image'>Image</a></li>"
  echo "<li><a href='./file'>File</a></li>"
  echo "<li><a href='./pdf'>PDF</a></li>"
  echo "<li><a href='./stream'>Steam</a></li>"
  echo "</ul>"


  echo "</body></html>"
  exit 0
fi

# default response
fail 400 "The route ${HTTP_REQUEST_URI} does not exist"