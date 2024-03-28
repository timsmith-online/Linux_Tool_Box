# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

PS1="\e[1;31m[Linux]\e[0m\e[1;32m[\T]\e[0m\e[1;33m[\W]\e[0m\e[1;34m$\e[0m"

function color_sync() {
        "$@" 2>&1 |
                GREP_COLOR='01;31' grep --color=always --line-buffered -Ei "down | no | bad |wrong|incorrect|improper|invalid|denied|not allowed|refused|problem|failed|failure|not permitted|invalid|not supported|fault|corruption|corrupted|corrupt|overflow|not ok|unsuccessfull|not implemented|errors|error| err |$" |
                GREP_COLOR='01;32' grep --color=always --line-buffered -Ei "alive| up |yes| ok |accepted|allowed|enabled|connected|successfully|successful|succeeded|success|$" |
                GREP_COLOR='01;33' grep --color=always --line-buffered -Ei "warning|problem|cannot|policyid|policytype|poluuid|policyname|appcat|$" |
                GREP_COLOR='01;34' grep --color=always --line-buffered -Ei "vlan| mac | port|srcip|srcport|srcintf|srcmac|mastersrcmac|srcswversion|devtype|osname|srchwvendor|$"
}

alias network="color_sync network.sh"
alias ll="ls -ltrh"
