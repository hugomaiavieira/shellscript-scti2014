# Simple gemset control based on http://goo.gl/pt8BGZ
#
# To use it, copy it for a dir of your preference (home for example) and add
# this line to your ~/.bashrc file:
#
#  . ~/omg.sh
#
# It supplies a environment variable OHMYGEMS_REPO that you can use on your PS1
#
export ORIG_GEM_PATH=${GEM_PATH:-}
export ORIG_GEM_HOME=${GEM_HOME:-}
export ORIG_PATH=${PATH}

ohmygems () {
  local REPOS_PATH
  local ERROR_MESSAGE
  local OMG_USAGE_MESSAGE

  REPOS_PATH="$HOME/.gem/repos"

  ERROR_MESSAGE="
\e[31mERROR:\e[0m Missing arguments!

To get help: ohmygems -h
"

  OMG_USAGE_MESSAGE="
Usage: ohmygems [name | OPTIONS]

Switches gem home to a named repo. IF the named repo does not exists, it will be
created when you install the first gem. The gems will be installed into
~/.gems/repos/<name>.

OPTIONS:

  -h | --help             Show this message
  -r | --reset            Go back to normal gem environment variables
  -l | --list             List available repos
  -m | --move OLD NEW     Rename the OLD repo to NEW
  -d | --delete REPOS     Delete the listed REPOS (with rm -rf)
"

  case "$1" in

    -h | --help )
      echo "$OMG_USAGE_MESSAGE"
      return 0
    ;;

    -r | --reset )
      echo "Resetting repo"

      unset OHMYGEMS_REPO
      GEM_HOME=${ORIG_GEM_HOME}
      GEM_PATH=${ORIG_GEM_PATH}
      PATH=$ORIG_PATH
      return 0
    ;;

    -l | --list )
      echo "Available repos:"
      echo ""
      ls $REPOS_PATH | pr -o2 -l1
      echo ""
      return 0
    ;;

    -m | --move )
      shift

      if [ -z "$1" ] || [ -z "$2" ]; then
        echo -e "$ERROR_MESSAGE"
        return 1
      fi

      echo "Renamed $1 to $2"
      mv "$REPOS_PATH/$1" "$REPOS_PATH/$2"

      [ "$OHMYGEMS_REPO" = "@$1" ] &&  OHMYGEMS_REPO="@$2"
      return 0
    ;;

    -d | --delete )
      shift

      if [ -z "$1" ]; then
        echo -e "$ERROR_MESSAGE"
        return 1
      fi

      echo "Removing, if exists, the following repos: $*"

      cd "$REPOS_PATH" && rm -rf $* && cd - > /dev/null

      # Check if one of the removed repos if active
      for repo in $*; do
        if [ "$repo" = "${OHMYGEMS_REPO#@}" ]; then
          # same as reset
          unset OHMYGEMS_REPO
          GEM_HOME=${ORIG_GEM_HOME}
          GEM_PATH=${ORIG_GEM_PATH}
          PATH=$ORIG_PATH
          return 0
        fi
      done
    ;;

    * )
      if [ -z "$1" ]; then
        echo -e "$ERROR_MESSAGE"
        return 1
      fi

      echo "Switch to $1"

      export OHMYGEMS_REPO="@$1" # for $PS1 use
      export GEM_HOME="$REPOS_PATH/$1"
      export GEM_PATH="$ORIG_GEM_HOME:$ORIG_GEM_PATH"
      export PATH="$GEM_HOME/bin:$ORIG_PATH" # the order matters
    ;;
  esac
}

# Auto complete
# _ohmygems() {
#   local current=${COMP_WORDS[COMP_CWORD]}
#   local options=$(ls ~/.gem/repos)
#   COMPREPLY=( $(compgen -W "$options" $current) )
# }
# complete -F _ohmygems ohmygems

# alias omg=ohmygems
