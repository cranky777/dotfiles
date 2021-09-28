autoload -U compinit
compinit

autoload -Uz is-at-least
if is-at-least 4.3.11
then
  autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
  add-zsh-hook chpwd chpwd_recent_dirs
  zstyle ':chpwd:*' recent-dirs-max 1000
  zstyle ':chpwd:*' recent-dirs-default yes
  zstyle ':completion:*' recent-dirs-insert both
fi

case ${UID} in
0)
    PROMPT="%B%{[31m%}%/#%{[m%}%b "
    PROMPT2="%B%{[31m%}%_#%{[m%}%b "
    SPROMPT="%B%{[31m%}%r is correct? [n,y,a,e]:%{[m%}%b "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
        PROMPT="%{[37m%}${HOST%%.*} ${PROMPT}"
    ;;
*)
    PROMPT="%{[31m%}%/%%%{[m%} "
    PROMPT2="%{[31m%}%_%%%{[m%} "
    SPROMPT="%{[31m%}%r is correct? [n,y,a,e]:%{[m%} "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
        PROMPT="%{[37m%}${HOST%%.*} ${PROMPT}"
    ;;
esac


### case "${TERM}" in
### kterm*|xterm*|screen)
###     precmd() {
###         echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
###     }
###     ;;
### esac


HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data

## alias設定
#
[ -f ~/.zshrc.alias ] && source ~/.zshrc.alias

case "${OSTYPE}" in
# Mac(Unix)
darwin*)
    # ここに設定
    [ -f ~/.zshrc.osx ] && source ~/.zshrc.osx
    ;;
# Linux
linux*)
    # ここに設定
    [ -f ~/.zshrc.linux ] && source ~/.zshrc.linux
    ;;
esac


# PATH=$PATH:$HOME/.rvm/bin:$HOME/bin # Add RVM to PATH for scripting
# [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin:$HOME/.pyenv/shims
export GO111MODULE=on

## Set path for pyenv
export PYENV_ROOT="${HOME}/.pyenv"
if [ -d "${PYENV_ROOT}" ]; then
    export PATH=${PYENV_ROOT}/bin:$PATH
    eval "$(pyenv init -)"
fi

# function ssh() {
#   if [[ -n $(printenv TMUX) ]]
#   then
#     local window_name=$(tmux display -p '#{window_name}')
#     tmux rename-window -- "$@[-1]" # zsh specified
#     # tmux rename-window -- "${!#}" # for bash
#     command ssh $@
#     tmux rename-window $window_name
#   else
#     command ssh $@
#   fi
# }

# filter
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS='--height 50% --layout=reverse --border'
FILTER=fzf
function filter-select-history() {
    # historyを番号なし、逆順、最初から表示。
    # 順番を保持して重複を削除。
    # カーソルの左側の文字列をクエリにしてpecoを起動
    # \nを改行に変換
### 		BUFFER="$(history -nr 1 | awk '!a[$0]++' | $FILTER --query "$LBUFFER" | sed 's/\\n/\n/')"
###     CURSOR=$#BUFFER             # カーソルを文末に移動
###     zle -R -c                   # refresh
		BUFFER=$(history -n -r 1 | fzf --no-sort +m --query "$LBUFFER" --prompt="History > ")
		CURSOR=$#BUFFER
		zle reset-prompt
}
zle -N filter-select-history
bindkey '^R' filter-select-history

function filter-kill () {
	ps -ef | $FILTER | awk '{ print $2 }' | xargs kill
    zle -R -c                   # refresh
}
zle -N filter-kill
alias "${FILTER}-kill"=filter-kill


# fd - cd to selected directory
fcd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}
zle -N fcd
alias fcd=fcd

export LANG="ja_JP.UTF-8"
