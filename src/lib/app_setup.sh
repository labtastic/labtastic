setup_app() {
  app_name=$1

  source .env.apps
  source .env

  if printf '%s\0' "${ENABLED_APPS[@]}" | grep -Fxqz "$app_name"; then
    error "app already installed"
    exit 1    
  fi

  NEW_APPS=""
  for app in ${ENABLED_APPS[@]}; do
    NEW_APPS="${NEW_APPS} \"$app\""
  done
  NEW_APPS="${NEW_APPS} \"$app_name\""
  echo "ENABLED_APPS=($NEW_APPS)" > .env.apps
  echo "# $1 Vars" >> .env
  cat "apps/$1/.env" >> .env
  echo "" >> .env

  mkdir -p "$APP_DATA/$1"

  if [ -d "apps/$1/data" ]; then
    rsync -avh apps/${1}/data/ ${APP_DATA}/${1}/
    find "$APP_DATA/$1" -name ".gitkeep" -type f -delete
  fi
}