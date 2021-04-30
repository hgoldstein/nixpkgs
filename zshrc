# If `powerline-go` is installed, use that as my shell
# Otherwise we have a nice pwetty prompt to use as a default

if type powerline-go > /dev/null; then

  function powerline_precmd() {
    PS1="$(powerline-go -newline -theme low-contrast -error $? -shell zsh)"
  }

  function install_powerline_precmd() {
    for s in "${precmd_functions[@]}"; do
      if [ "$s" = "powerline_precmd" ]; then
        return
      fi
    done
    precmd_functions+=(powerline_precmd)
  }

  if [ "$TERM" != "linux" ]; then
    install_powerline_precmd
  fi

else

  export PROMPT='%~ %# '

fi


eval "$(direnv hook zsh)"
