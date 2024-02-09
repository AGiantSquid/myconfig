# include .bashrc if it exists
if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
fi

eval "$(/opt/homebrew/bin/brew shellenv)"
