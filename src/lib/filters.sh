filter_docker_running() {
  docker info > /dev/null 2>&1 || echo "Docker must be running"
}