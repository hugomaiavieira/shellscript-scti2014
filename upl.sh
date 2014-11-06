# This command receives a file as param, upload it to upl.io and copy the url to
# the clipboard
#
# Dependencies: curl and xclip
#
# Install: copy this code to your .bashrc or .zshrc
#
# Example:
#
#   $ upload_file ~/Images/algorich-logo.png
#   Uploading...
#   http://upl.io/mgun63
#

upl() {
  local url
  local curl_response

  echo 'Uploading...'
  url=`curl http://upl.io -F file=@$1 -s -f`
  curl_response=$?

  echo -n $url | xclip -selection c
  echo $url

  if [[ "$curl_response" = '0' ]] && [[ "$2" = '-d' ]]; then
    rm $1
  fi
}
