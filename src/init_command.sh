if [ -f ".labtastic-init-done" ]; then
  error "labtastic init already done. exiting..."
  exit 1
fi

info "Setting up Labtastic environment..."

if ! command -v curl &> /dev/null
then
  error "missing dependency 'curl'"
  exit 1
fi

if ! command -v docker &> /dev/null
then
  info "Installing docker..."
  curl -fsSL https://get.docker.com | bash
  sudo usermod -A -G docker "$(whoami)"
else
  info "docker already installed"
fi

docker network create --subnet "10.255.0.0/16" --attachable labtastic 

if [ ! -d "${args[appdata]}" ]; then
  info "creating app data directory: ${args[appdata]}"
  sudo mkdir -p "${args[appdata]}"
  sudo chown -R "$(id -u):$(id -g)" "${args[appdata]}"
else
  info "app data directory already exists"
  sudo chown "$(id -u):$(id -g)" "${args[appdata]}"
fi

info "creating initial .env config"

echo "### ENABLED APPS ###" > .env
echo "ENABLED_APPS=()" >> .env
echo "### Global ENV Vars ###" >> .env
echo "# dns base domain" >> .env
echo "DOMAIN=\"changeme\"" >> .env
echo "# directory where app data will be stored" >> .env
echo "APP_DATA=\"${args[appdata]}\"" >> .env
echo "# Use watchtower to auto update containers" >> .env
echo "AUTO_UPDATE=\"true\"" >> .env
echo "" >> .env
echo "### Application Specific Vars ###" >> .env

touch .labtastic-init-done

info "Labtastic is now intialized!"

echo "$(yellow WARNING: Please review and update .env before running './labtastic install')"

exit 0