#Common Shell tools
export LANG=en_US.UTF-8

export HISTCONTROL=erasedups

alias ll="ls -lah"

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

alias grep="grep --color"
alias fgrep="fgrep --color"
alias egrep="egrep --color"

export VISUAL='nvim'
export EDITOR=$VISUAL
alias vi="nvim"
alias vim="nvim"

[[ -f ~/.bash_prompt ]] && source ~/.bash_prompt

if [[ $- == *i* ]]; then
    # Setup colors in case this is a terminal
    COLOR_SCRIPT=$HOME/opt/base16-shell/scripts/base16-default-dark.sh
    if [[ -r "$COLOR_SCRIPT" ]]; then
        source "$COLOR_SCRIPT"
    fi
fi
