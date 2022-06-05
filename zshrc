# Set up `emacs` mode so Ctrl-A and Ctrl-E work as expected
bindkey -e
# If `cargo` has anything installed, we'll want to see it
source "$HOME/.cargo/env"
# Set up `direnv`, which can run programs as you enter a directory
eval "$(direnv hook zsh)"
