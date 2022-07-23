generate_compose_files_list() {
  source .env

  files=""

  for app in ${!ENABLED_APPS[@]}; do
    if [[ $app -eq 1 ]]; then
      files="apps/$app/docker-compose.yml"
    else
      files="${files}:apps/$app/docker-compose.yml"
    fi
  done

  echo $files
}

generate_compose_profiles() {
  source .env

  profiles=""

  for app in ${!ENABLED_APPS[@]}; do
    if [[ $app -eq 1 ]]; then
      files="$app"
    else
      files="${files},$app"
    fi
  done

  echo $profiles
}

docker_compose_setup() {
  export COMPOSE_PATH_SEPARATOR=":"
  export COMPOSE_FILE=$(generate_compose_files_list)
  export COMPOSE_PROFILES="$1-setup"

  docker compose --project-directory $(pwd) up -d
}

docker_compose_up() {
  export COMPOSE_PATH_SEPARATOR=":"
  export COMPOSE_FILE=$(generate_compose_files_list)
  export COMPOSE_PROFILES=$(generate_compose_profiles)

  docker compose --project-directory $(pwd) up -d 
}

docker_compose_stop_all() {
  export COMPOSE_PATH_SEPARATOR=":"
  export COMPOSE_FILE=$(generate_compose_files_list)
  export COMPOSE_PROFILES=$(generate_compose_profiles)
  
  docker compose --project-directory $(pwd) stop 
}

docker_compose_stop() {
  export COMPOSE_PATH_SEPARATOR=":"
  export COMPOSE_FILE=$(generate_compose_files_list)
  export COMPOSE_PROFILES="$1,$1-setup"

  docker compose --project-directory $(pwd) stop
}