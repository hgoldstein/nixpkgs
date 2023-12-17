# Set up `emacs` mode so Ctrl-A and Ctrl-E work as expected
bindkey -e
# If `cargo` has anything installed, we'll want to see it
if [ -f "$HOME/.cargo/env" ]; then; source "$HOME/.cargo/env"; fi
# Set up `direnv`, which can run programs as you enter a directory
eval "$(direnv hook zsh)"
export PURE_PROMPT_SYMBOL="λ"
alias tree="exa -T"
