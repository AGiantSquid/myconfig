# Use these settings if using debian in WSL
if [ -d /c/Users ]; then
  export PATH="$HOME/bin:$HOME/.local/bin:$PATH"
  export PATH="$PATH:/mnt/c/Program\ Files/Docker/Docker/resources/bin"

  # For xming, displaying debian gui programs in windows host
  export DISPLAY=localhost:0.0

  # Needed to run docker commands from Windows
  export DOCKER_HOST=localhost:2375

  alias sublime='"/c/Program Files/Sublime Text 3/sublime_text.exe"'
  alias home='cd /c/Users/$USER/; ls'
  alias green='cd /c/Users/$USER/GreenKey/; ls'
  alias scribe='cd /c/Users/$USER/GreenKey/scribe; ls'
  alias discover='cd /c/Users/$USER/GreenKey/scribe/projects/discovery; ls'
else
  alias sublime='/usr/bin/subl'
  alias home='cd; ls'
  alias green='cd ~/GreenKey/; ls'
  alias scribe='cd ~/GreenKey/scribe; ls'
  alias discover='cd ~/GreenKey/scribe/projects/discovery; ls'
fi

# needed to use git versioning on this file and others
alias config='/usr/bin/git --git-dir=/home/$USER/.myconfig/ --work-tree=/home/$USER'

# file listing
alias ll='ls -l'
alias la='ls -A'

# directory navigation
alias ..='cd ..'
alias ...='cd ../../../'
alias ....='cd ../../../../'
alias .....='cd ../../../../'

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
    sudo find . -name ".pytest_cache" -type d -exec rm -r "{}" \;
}

# node stuff
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# go stuff
export GOROOT="/usr/local/go"
export GOPATH="$HOME/go_projects"
export GOBIN="$GOPATH/bin"
export PATH=$PATH:$GOROOT/bin:$GOBIN

# GreenKey related stuff
export GIT_SSH=/drive/ashley/gitwrap.sh
export PYTHONPATH=${PYTHONPATH}:/c/Users/a/GreenKey/scribe/projects/scribekaldi/src/gktbase
