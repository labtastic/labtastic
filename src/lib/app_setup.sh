setup_app() {
  app_name=$1

  echo "# $1 Vars" >> .env
  cat "apps/$1/.env" >> .env
  echo "" >> .env

  mkdir -p "$APP_DATA/$1"

  if [ -d "./apps/$1/data" ]; then
    cp --recursive --update "./apps/$1/data" --target-directory="$APP_DATA/$1"
    find "$APP_DATA/$1" -name ".gitkeep" -t f -delete
  fi
}