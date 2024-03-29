# Use these settings if using debian in WSL
if [ -d /c/Users ]; then
  export PATH="$HOME/bin:$HOME/.local/bin:$PATH"
  export PATH="$PATH:/mnt/c/Program\ Files/Docker/Docker/resources/bin"

  # For xming, displaying debian gui programs in windows host
  export DISPLAY=localhost:0.0

  # Needed to run docker commands from Windows
  export DOCKER_HOST=localhost:2375

  alias home='cd /c/Users/$USER/; ls'
else
  alias home='cd; ls'
fi

# needed to use git versioning on this file and others
alias config='/usr/bin/git --git-dir=/$HOME/.myconfig/ --work-tree=$HOME'

# file listing
alias ll='ls -l'
alias la='ls -A'

# directory navigation
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias ......='cd ../../../../../'

# list open ports
alias ports='netstat -tulanp'

# docker aliases
alias d='docker'
alias dpa='docker ps -a'
alias dk='docker kill'
alias dl='docker logs -f'
function de() {
  docker exec -it "$1" bash
}
function des() {
  docker exec -it "$1" sh
}

alias gc='git commit'
alias gco='git checkout'


# remove python garbage that gets generated
pyclean () {
    sudo find . -regex '^.*\(__pycache__\|\.py[co]\)$' -delete;
    sudo find . -name ".pytest_cache" -type d -prune -exec rm -r '{}' '+'
    sudo find . -regex '^.*egg.info$' -type d -prune -exec rm -r '{}' '+'
}

# uninstall all packages
pip_purge () {
  pip freeze | grep -v "^-e" | xargs pip uninstall -y
}

# make project current with dev
git_fresh () {
  git co develop &&
  git pull &&
  cd serverless_utils/ &&
  git co develop &&
  git pull &&
  cd ../ &&
  git branch --merged develop
}
