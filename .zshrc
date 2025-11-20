PROMPT="%F{red}[local]%f%F{green}[%T]%f%F{blue}[%1d]%f%F{yellow}$%f "
RPROMPT="%F{015}%T%f"



function hl_color() {
  "$@" 2>&1 |
    GREP_COLOR='01;31' grep --color=always --line-buffered -Ewi "exdl|cisco|cisco ios switch|firewall|down|no|bad|wrong|incorrect|improper|invalid|denied|not allowed|refused|problem|failed|failure|not permitted|invalid|not supported|fault|corruption|corrupted|corrupt|overflow|not ok|unsuccessfull|not implemented|errors|error|err|$" |
    GREP_COLOR='01;32' grep --color=always --line-buffered -Ewi "exal|(mssc-[A-Za-z0-9-]+)|palo alto|ngfw|alive|up|yes|ok|accepted|allowed|enabled|connected|successfully|successful|succeeded|success|$" |
    GREP_COLOR='01;33' grep --color=always --line-buffered -Ewi "exbl|juniper|warning|problem|cannot|policyid|policytype|poluuid|policyname|appcat|$" |
    GREP_COLOR='01;34' grep --color=always --line-buffered -Ewi "(msrc-[A-Za-z0-9-]+)|exhc|arista|meraki|router|vlan|mac|port|srcip|srcport|srcintf|srcmac|mastersrcmac|srcswversion|devtype|osname|srchwvendor|$" |
    GREP_COLOR='01;35' grep --color=always --line-buffered -Ewi "exwr|extreme|vsp|asa|firepower|ise|mds|meraki|nexus|wlc|$" |
    GREP_COLOR='01;36' grep --color=always --line-buffered -Ewi "\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b|$"
                
                
}


function run_expect() {
    local ip="$1"
    local cmd="$2"
    expect <<EOF
spawn ~/site_id/zshrc-EX-cmd.exp "$ip" "$cmd"
expect eof
EOF
}

function connect_switch {
    argc=$1
    ~/site_id/v2.exp "$argc" | unbuffer hl_color 
}

function etc_hosts() {
  arg1=$1
  hl_color cat ~/etc/host_ids.csv | awk -F, '{print $1 " " $2}' | grep -i "$arg1"
}

function new_etc_hosts() {
  arg1=$1
  hl_color cat ~/etc/host_ids.csv | awk -F, '{print $1 " " $2 " " $7}' | grep -i "$arg1"
}

function old_etc_hosts() {
  arg1=$1
  hl_color cat ~/etc/host_ids_1.csv | awk -F, '{print $1 " " $2 " " $3 " " $4 " " $7}' | grep -i "$arg1"
}

function tss() {
  arg=$1
  ~/site_id/v2.exp "$arg" | sed -l 's/yes/\x1b[32myes\x1b[0m/g' 
}


# Color definitions
RESET="\033[0m"
BOLD="\033[1m"
HEADER_COLOR="\033[34m"  # Blue for headers
BOLD_COLOR="\033[32m"    # Green for bold text
CODE_COLOR="\033[33m"    # Yellow for code blocks
ITALIC_COLOR="\033[36m"  # Cyan for italic text

# Markdown color highlighting function
function markdown_highlight() {
    while IFS= read -r line; do
        # Match headers
        if [[ "$line" =~ ^\# ]]; then
            echo "${HEADER_COLOR}${line}${RESET}"

        # Match bold text (simplified for **bold**)
        elif [[ "$line" =~ \*\*.*\*\* ]]; then
            echo "${BOLD}${BOLD_COLOR}${line}${RESET}"

        # Match italic text (_italic_)
        elif [[ "$line" =~ _.*_ ]]; then
            echo "${ITALIC_COLOR}${line}${RESET}"

        # Match inline code (`code`)
        elif [[ "$line" =~ \`.*\` ]]; then
            echo "${CODE_COLOR}${line}${RESET}"

        # Match code blocks (```code```)
        elif [[ "$line" =~ ^\`\`\` ]]; then
            echo "${CODE_COLOR}${line}${RESET}"
        
        # Default output for unformatted text
        else
            echo "$line"
        fi
    done
}

# Alias to make it easy to use
alias mdh='markdown_highlight'
alias mux="tmux new-session \; split-window -h \; send-keys 'vim /path/' C-m"
alias ll="ls -lthra --color=always"
alias ls="ls -aC --color=always"
alias l="ls -aC --color=always *"
alias onb="vim ~/Documents/onb.md"
alias kb="vim ~/etc/KB/Knowledge_Base.md"
alias bck_up="scp ./* xx@0.0.0.0:/home/xx/downloads"
alias bck_up_kb="scp ~/etc/KB/Knowledge_Base.md xx@0.0.0.0:/home/xx/Documents/Knowledge_Base.md"
alias build_code="cat ~/etc/Building_Codes.md | grep -i"
alias look="in2csv debug.xlsx | csvlook"
alias act="source env/bin/activate"
alias con="screen /dev/tty.XXXXXX 115200"

alias gc="~/site_id/zshrc-EX-cmd.exp"
alias exscp="~/site_id/log_exSE.exp"
alias hlc="hl_color ~/site_id/v1.exp"
alias hlc2="hl_color ~/site_id/v2.exp"

alias qwe="etc_hosts"
alias ewq="cat ~/etc/host_ids.csv | awk -F, '{print \$1, \$2}' | grep -i"
alias qq="cat ~/etc/host_ids.csv | awk -F, '{print \$2, \$1}' | grep -i"
alias qw="~/site_id/v6.exp"
alias wq="~/site_id/v8.exp"
alias my="mysql -u root -p"

alias the_sh="vim ~/Documents/script_flow.md"
alias todo="vim ~/etc/TO-DO_NOTES.md"

#30: Black
#31: Red
#32: Green
#33: Yellow
#34: Blue
#35: Magenta
#36: CyanW
#37: White

