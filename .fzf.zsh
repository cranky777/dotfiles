# Setup fzf
# ---------
if [[ ! "$PATH" == */home/bot/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/bot/.fzf/bin"
fi

source <(fzf --zsh)
