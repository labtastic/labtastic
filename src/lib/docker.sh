docker_compose_setup() {
  env $(cat .env | grep -v "^#" | xargs ) docker compose --project-name labtastic --profile "$1-setup" -f apps/${1}/docker-compose.yml up -d
}

docker_compose_up() {
  env $(cat .env | grep -v "^#" | xargs ) docker compose --project-name labtastic --profile "$1" -f apps/${1}/docker-compose.yml up -d
}

docker_compose_stop_all() {
  source .env
  for app in ${ENABLED_APPS[@]}; do
    env $(cat .env | grep -v "^#" | xargs ) docker compose --project-name labtastic --profile "$app" -f apps/${app}/docker-compose.yml stop
  done
}

docker_compose_stop() {
  env $(cat .env | grep -v "^#" | xargs ) docker compose -project-name labtastic --profile "$1" -f apps/${1}/docker-compose.yml stop
}

docker_compose_start_all() {
  source .env
  for app in ${ENABLED_APPS[@]}; do
    env $(cat .env | grep -v "^#" | xargs ) docker compose --project-name labtastic --profile "$app" -f apps/${app}/docker-compose.yml start
  done
}

docker_compose_start() {
  env $(cat .env | grep -v "^#" | xargs ) docker compose --project-name labtastic --profile "$1" -f apps/${1}/docker-compose.yml start
}