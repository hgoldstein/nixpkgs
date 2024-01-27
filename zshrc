# Set up `emacs` mode so Ctrl-A and Ctrl-E work as expected
bindkey -e
# If `cargo` has anything installed, we'll want to see it
if [ -f "$HOME/.cargo/env" ]; then; source "$HOME/.cargo/env"; fi
alias tree="exa -T"
# Set up `direnv`, which can run programs as you enter a directory
eval "$(direnv hook zsh)"
