function info() {
  echo "$(green INFO: $@)"
}

function warn() {
  echo "$(yellow WARN: $@)"
}

function error() {
  echo "$(red ERROR: $@)"
}