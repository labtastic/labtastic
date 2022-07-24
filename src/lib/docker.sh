generate_compose_files_list() {
  source .env

  files=""

  for app in ${ENABLED_APPS[@]}; do
      files="-f apps/${ENABLED_APPS[$app]}/docker-compose.yml "
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
  compose_files=$(generate_compose_files_list)
  env $(cat .env | grep -v "^#" | grep -v "ENABLED_APPS" |  xargs ) docker compose --project-name labtastic --profile "$1-setup" ${compose_files} up -d
}

docker_compose_up() {
  compose_files=$(generate_compose_files_list)
  env $(cat .env | grep -v "^#" | grep -v "ENABLED_APPS" | xargs ) docker compose --project-name labtastic --profile "$1" ${compose_files} up -d
}

docker_compose_down() {
  compose_files=$(generate_compose_files_list)
  env $(cat .env | grep -v "^#" | grep -v "ENABLED_APPS" | xargs ) docker compose --project-name labtastic --profile "$1" ${compose_files} down
}

docker_compose_stop_all() {
  compose_files=$(generate_compose_files_list)
  env $(cat .env | grep -v "^#" | grep -v "ENABLED_APPS" | xargs ) docker compose --project-name labtastic --profile "$app" ${compose_files} stop
}

docker_compose_stop() {
  compose_files=$(generate_compose_files_list)
  env $(cat .env | grep -v "^#" | grep -v "ENABLED_APPS" | xargs ) docker compose --project-name labtastic --profile "$1" ${compose_files} stop
}

docker_compose_start_all() {
  compose_files=$(generate_compose_files_list)
  env $(cat .env | grep -v "^#" | grep -v "ENABLED_APPS" | xargs ) docker compose --project-name labtastic --profile "$app" ${compose_files}l start
  
}

docker_compose_start() {
  compose_files=$(generate_compose_files_list)
  env $(cat .env | grep -v "^#" | grep -v "ENABLED_APPS" | xargs ) docker compose --project-name labtastic --profile "$1" ${compose_files} start
}

docker_compose_status() {
  compose_files=$(generate_compose_files_list)
  compose_profiles=$(generate_compose_profiles)
  env $(cat .env | grep -v "^#" | grep -v "ENABLED_APPS" | xargs ) docker compose --project-name labtastic --profile ${compose_profiles} ${compose_files} status
}

docker_compose_logs() {
  compose_files=$(generate_compose_files_list)
  env $(cat .env | grep -v "^#" | xargs ) docker compose --project-name labtastic --profile "$1" ${compose_files} logs -f "$2"
}