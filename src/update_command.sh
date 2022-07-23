info "updating labtastic and apps"

git pull || git stash && git pull && git stash apply

info "finished updating labtastic and apps"