#/bin/sh

StatusContinue=100 # RFC 7231, 6.2.1
StatusSwitchingProtocols=101 # RFC 7231, 6.2.2
StatusProcessing=102 # RFC 2518, 10.1
StatusEarlyHints=103 # RFC 8297

StatusOK=200 # RFC 7231, 6.3.1
StatusCreated=201 # RFC 7231, 6.3.2
StatusAccepted=202 # RFC 7231, 6.3.3
StatusNonAuthoritativeInfo=203 # RFC 7231, 6.3.4
StatusNoContent=204 # RFC 7231, 6.3.5
StatusResetContent=205 # RFC 7231, 6.3.6
StatusPartialContent=206 # RFC 7233, 4.1
StatusMultiStatus=207 # RFC 4918, 11.1
StatusAlreadyReported=208 # RFC 5842, 7.1
StatusIMUsed=226 # RFC 3229, 10.4.1

StatusMultipleChoices=300 # RFC 7231, 6.4.1
StatusMovedPermanently=301 # RFC 7231, 6.4.2
StatusFound=302 # RFC 7231, 6.4.3
StatusSeeOther=303 # RFC 7231, 6.4.4
StatusNotModified=304 # RFC 7232, 4.1
StatusUseProxy=305 # RFC 7231, 6.4.5

StatusTemporaryRedirect=307 # RFC 7231, 6.4.7
StatusPermanentRedirect=308 # RFC 7538, 3

StatusBadRequest=400 # RFC 7231, 6.5.1
StatusUnauthorized=401 # RFC 7235, 3.1
StatusPaymentRequired=402 # RFC 7231, 6.5.2
StatusForbidden=403 # RFC 7231, 6.5.3
StatusNotFound=404 # RFC 7231, 6.5.4
StatusMethodNotAllowed=405 # RFC 7231, 6.5.5
StatusNotAcceptable=406 # RFC 7231, 6.5.6
StatusProxyAuthRequired=407 # RFC 7235, 3.2
StatusRequestTimeout=408 # RFC 7231, 6.5.7
StatusConflict=409 # RFC 7231, 6.5.8
StatusGone=410 # RFC 7231, 6.5.9
StatusLengthRequired=411 # RFC 7231, 6.5.10
StatusPreconditionFailed=412 # RFC 7232, 4.2
StatusRequestEntityTooLarge=413 # RFC 7231, 6.5.11
StatusRequestURITooLong=414 # RFC 7231, 6.5.12
StatusUnsupportedMediaType=415 # RFC 7231, 6.5.13
StatusRequestedRangeNotSatisfiable=416 # RFC 7233, 4.4
StatusExpectationFailed=417 # RFC 7231, 6.5.14
StatusTeapot=418 # RFC 7168, 2.3.3
StatusMisdirectedRequest=421 # RFC 7540, 9.1.2
StatusUnprocessableEntity=422 # RFC 4918, 11.2
StatusLocked=423 # RFC 4918, 11.3
StatusFailedDependency=424 # RFC 4918, 11.4
StatusTooEarly=425 # RFC 8470, 5.2.
StatusUpgradeRequired=426 # RFC 7231, 6.5.15
StatusPreconditionRequired=428 # RFC 6585, 3
StatusTooManyRequests=429 # RFC 6585, 4
StatusRequestHeaderFieldsTooLarge=431 # RFC 6585, 5
StatusUnavailableForLegalReasons=451 # RFC 7725, 3

StatusInternalServerError=500 # RFC 7231, 6.6.1
StatusNotImplemented=501 # RFC 7231, 6.6.2
StatusBadGateway=502 # RFC 7231, 6.6.3
StatusServiceUnavailable=503 # RFC 7231, 6.6.4
StatusGatewayTimeout=504 # RFC 7231, 6.6.5
StatusHTTPVersionNotSupported=505 # RFC 7231, 6.6.6
StatusVariantAlsoNegotiates=506 # RFC 2295, 8.1
StatusInsufficientStorage=507 # RFC 4918, 11.5
StatusLoopDetected=508 # RFC 5842, 7.2
StatusNotExtended=510 # RFC 2774, 7
StatusNetworkAuthenticationRequired=511 # RFC 6585, 6

declare -a HTTP_RESPONSE_MESSAGE=(
  [100]="Continue"
  [101]="Switching Protocols"
  [102]="Processing"
  [103]="Early Hints",
  [200]="OK"
  [201]="Created"
  [202]="Accepted"
  [203]:"Non-Authoritative Information"
  [204]="No Content"
  [205]="Reset Content"
  [206]="Partial Content"
  [207]="Multi-Status"
  [208]:"Already Reported"
  [226]="IM Used"
  [300]:"Multiple Choices"
  [301]:"Moved Permanently"
  [302]="Found"
  [303]="See Other"
  [304]="Not Modified"
  [305]="Use Proxy"
  [307]:"Temporary Redirect"
  [308]:"Permanent Redirect"
  [400]="Bad Request"
  [401]="Unauthorized"
  [402]="Payment Required"
  [403]="Forbidden"
  [404]="Not Found"
  [405]="Method Not Allowed"
  [406]="Not Acceptable"
  [407]="Proxy Authentication Required"
  [408]="Request Timeout"
  [409]="Conflict"
  [410]="Gone"
  [411]="Length Required"
  [412]="Precondition Failed"
  [413]="Request Entity Too Large"
  [414]="Request URI Too Long"
  [415]="Unsupported Media Type"
  [416]:"Requested Range Not Satisfiable"
  [417]="Expectation Failed"
  [418]="I'm a teapot"
  [421]="Misdirected Request"
  [422]="Unprocessable Entity"
  [423]="Locked"
  [424]="Failed Dependency"
  [425]="Too Early"
  [426]="Upgrade Required"
  [428]="Precondition Required"
  [429]="Too Many Requests"
  [431]:"Request Header Fields Too Large"
  [451]:"Unavailable For Legal Reasons"
  [500]="Internal Server Error"
  [501]="Not Implemented"
  [502]="Bad Gateway"
  [503]="Service Unavailable"
  [504]="Gateway Timeout"
  [505]="HTTP Version Not Supported"
  [506]="Variant Also Negotiates"
  [507]="Insufficient Storage"
  [508]="Loop Detected"
  [510]="Not Extended"
  [511]="Network Authentication Required"
)

function http_add_header() {
  echo "$1: $2" >&1;
}

# TODO: map http code to text
function http_message() {
  code=$1
  msg=${HTTP_RESPONSE[$1]}
  echo "HTTP/1.0 $code $msg" >&1;
} 

function http_set_content_type() {
  http_add_header "Content-Type" $1
}

function http_set_content_length() {
  http_add_header "Content-Length" $1
}

function http_message_body() {
  echo '' >&1;
}

# TODO: fix OK
function http_response {
  http_message $1
  http_add_header "Server" "vesper"
  http_set_content_type $2
  http_message_body
}

# TODO: fix http message
function fail() {
  http_message $1
  http_add_header "Server" "vesper"
  http_set_content_type "text/plain"
  http_message_body
  echo $2
  exit 1
}

HTTP_REQUEST_METHOD=""
HTTP_REQUEST_URI=""
HTTP_REQUEST_HTTP_VERSION=""
declare -a HTTP_REQUEST_HEADERS

function http_request() {
  recv() { echo "< $@" >&2; }
  
  # HTTP RFC 2616 $5.1 request line
  # https://tools.ietf.org/html/rfc2616#section-5.1
  read -r raw
  # if there is any trailing CR, strip it
  raw=${raw%%$'\r'}
  recv "$raw"
  read -r HTTP_REQUEST_METHOD HTTP_REQUEST_URI HTTP_REQUEST_HTTP_VERSION <<<"$raw"

  while read -r raw; do
    raw=${raw%%$'\r'}
    recv "$raw"

    # check if we reached the end of the headers
    [ -z "$raw" ] && break

    HTTP_REQUEST_HEADERS+=("$raw")
  done
}

function file_size() {
  echo $(stat -f%z $1)
}

function file_mime() {
  echo $(file --mime-type -b $1)
}

function http_sendfile() {
  file=$1
  http_message StatusOK
  http_add_header "Server" "vesper"
  http_set_content_type $(file_mime $file)
  http_set_content_length $(file_size $file)
  http_message_body
  cat ${file} >&1
}