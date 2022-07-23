if [ ! ${args[--stop]} -eq 1 || ! ${args[--start]} -eq 1 ]; then
  error "must specify an action (--start/--stop)"
fi

if [ ${args[--stop]} -eq 1 ]; then
  if [ ${args[appname]} -eq "all" ]; then
    docker_compose_stop_all
  else
    docker_compose_stop "${args[appname]}"
  fi
fi

if [ ${args[--start]} -eq 1 ]; then
  if [ ${args[appname]} -eq "all" ]; then
    docker_compose_start_all
  else
    docker_compose_start "${args[appname]}"
  fi
fi