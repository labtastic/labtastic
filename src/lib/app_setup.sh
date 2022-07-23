setup_app() {
  app_name=$1

  source .env

  echo "# $1 Vars" >> .env
  cat "apps/$1/.env" >> .env
  echo "" >> .env

  mkdir -p "$APP_DATA/$1"

  if [ -d "apps/$1/data" ]; then
    rsync -avh apps/${1}/data/ ${APP_DATA}/${1}/
    find "$APP_DATA/$1" -name ".gitkeep" -type f -delete
  fi
}