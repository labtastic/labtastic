generate_compose_files_list() {
  source .env

  files=""

  for app in ${!ENABLED_APPS[@]}; do
    if [[ $app -eq 1 ]]; then
      files="apps/${ENABLED_APPS[$app]}/docker-compose.yml"
    else
      files="${files}:apps/${ENABLED_APPS[$app]}/docker-compose.yml"
    fi
  done

  echo $files
}

generate_compose_profiles() {
  source .env

  profiles=""

  for app in ${!ENABLED_APPS[@]}; do
    if [[ $app -eq 1 ]]; then
      files="${ENABLED_APPS[$app]}"
    else
      files="${files},${ENABLED_APPS[$app]}"
    fi
  done

  echo $profiles
}

docker_compose_setup() {
  docker compose --project-name labtastic --profile "$1-setup" -f apps/${1}/docker-compose.yml up -d
}

docker_compose_up() {
  docker compose --project-name labtastic --profile "$1" -f apps/${1}/docker-compose.yml up -d
}

docker_compose_stop_all() {
  source .env
  for app in ${ENABLED_APPS[@]}; do
    docker compose --project-name labtastic --profile "$app" -f apps/${app}/docker-compose.yml stop
  done
}

docker_compose_stop() {
  docker compose -project-name labtastic --profile "$1" -f apps/${1}/docker-compose.yml stop
}

docker_compose_start_all() {
  source .env
  for app in ${ENABLED_APPS[@]}; do
    docker compose --project-name labtastic --profile "$app" -f apps/${app}/docker-compose.yml start
  done
}

docker_compose_start() {
  docker compose --project-name labtastic --profile "$1" -f apps/${1}/docker-compose.yml start
}