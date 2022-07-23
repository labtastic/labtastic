if [ ! "${args[--stop]}" == "1" || ! "${args[--start]}" == "1" ]; then
  error "must specify an action (--start/--stop)"
fi

if [ "${args[--stop]}" == "1" ]; then
  if [ "${args[appname]}" == "all" ]; then
    docker_compose_stop_all
  else
    docker_compose_stop "${args[appname]}"
  fi
fi

if [ "${args[--start]}" == "1" ]; then
  if [ "${args[appname]}" == "all" ]; then
    docker_compose_start_all
  else
    docker_compose_start "${args[appname]}"
  fi
fi