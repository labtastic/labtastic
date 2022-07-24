if [ ! -f "apps/${args[appname]}/.setup-done" ]; then
  setup_app "${args[appname]}"
  touch "apps/${args[appname]}/.setup-done"
  info "please view/update values for ${args[appname]} app in .env then rerun this command again"
  exit 0
fi

docker_compose_setup "${args[appname]}"

info "setup for ${args[appname]} app finished!"
info "please run './labtastic up ${args[appname]}' to finish installation"