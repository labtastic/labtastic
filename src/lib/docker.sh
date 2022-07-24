generate_compose_files_list() {
  source .env.apps

  files=""

  for app in ${ENABLED_APPS[@]}; do
      files="$files -f apps/$app/docker-compose.yml"
  done

  echo $files
}

docker_compose_setup() {
  env $(cat .env | grep -v "^#" | grep -v "ENABLED_APPS" |  xargs ) docker compose --project-name labtastic --profile "$1-setup" -f apps/${1}/docker-compose.yml up -d
}

docker_compose_up() {
  env $(cat .env | grep -v "^#" | grep -v "ENABLED_APPS" | xargs ) docker compose --project-name labtastic -f apps/${1}/docker-compose.yml up -d
}

docker_compose_up_all() {
  compose_files=$(generate_compose_files_list)
  echo $compose_files
  env $(cat .env | grep -v "^#" | grep -v "ENABLED_APPS" | xargs ) docker compose --project-name labtastic ${compose_files} up -d
}

docker_compose_down() {
  env $(cat .env | grep -v "^#" | grep -v "ENABLED_APPS" | xargs ) docker compose --project-name labtastic -f apps/${1}/docker-compose.yml down
}

docker_compose_down_all() {
  compose_files=$(generate_compose_files_list)
  env $(cat .env | grep -v "^#" | grep -v "ENABLED_APPS" | xargs ) docker compose --project-name labtastic ${compose_files} down
}

docker_compose_stop() {
  env $(cat .env | grep -v "^#" | grep -v "ENABLED_APPS" | xargs ) docker compose --project-name labtastic -f apps/${1}/docker-compose.yml stop
}

docker_compose_start() {
  env $(cat .env | grep -v "^#" | grep -v "ENABLED_APPS" | xargs ) docker compose --project-name labtastic -f apps/${1}/docker-compose.yml start
}

docker_compose_status() {
  compose_files=$(generate_compose_files_list)
  env $(cat .env | grep -v "^#" | grep -v "ENABLED_APPS" | xargs ) docker compose --project-name labtastic ${compose_files} ps
}

docker_compose_logs() {
  compose_files=$(generate_compose_files_list)
  env $(cat .env | grep -v "^#" | xargs ) docker compose --project-name labtastic ${compose_files} logs -f "$1"
}