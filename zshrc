# If `powerline-go` is installed, use that as my shell
# Otherwise we have a nice pwetty prompt to use as a default

export PROMPT='%~ %# '

eval "$(direnv hook zsh)"
