# Setup fzf
# ---------
if [[ ! "$PATH" == */home/nori/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/nori/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/nori/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
key_bindings="/home/nori/.fzf/shell/key-bindings.zsh"
[ -f $key_bindings ] && source $key_bindings
