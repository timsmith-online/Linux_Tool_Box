#!/bin/bash

# Error Handling
# set -e

# Global List of Var's
DATE=$(date +"%Y-%m-%d")
# grep filter
TLOG=$(tmp_log $1 | grep -i '2023-')
RTRO=$(./v3.sh $1)
ITEM=$1




current_log() {
  # Prints todays log, if none, then lasts log
  local last_log=$(echo "$TLOG" | tail -n1)
  local today_log=$(echo "$TLOG" | grep -i $DATE)
  if [[ -z $today_log ]]; then
    echo "$ITEM: no logs from $DATE, last log:"
    echo "$last_log"
  else
    echo "$ITEM: Today's log: $DATE"
    echo "$today_log"
  fi
  # function returns:
  # Prints todays/last logs found in tmp_log
}



  
count_sterm() {
  # Count tunnel entry for 2023
  local term_count=$(echo "$TLOG" | grep Tunnel | wc | awk '{print$1}')
  echo "$ITEM: Tunnel count: $term_count"
  # function returns:
  # Tunnel count: #count

}




scurrent_log() { 
  # Checks the last log and prints the issue of any ipsec tunnel
  # Tunnel issue reports right, but if: (TUN Condition=OK and ODD# Tunnels=down)=wan2 down, wan2 link-monitor down
  local log_check=$(echo "$TLOG" | grep Tunnel | tail -n1 | grep -o 'OK\|WARNING\|CRITICAL')
  if [[ -z $TLOG ]]; then
    echo "$ITEM: Check site activation"
  else
    if [[ "$log_check" == "OK" ]]; then
      echo "$ITEM: TUN Condition -- OK"
    elif [[ "$log_check" == "WARNING" ]]; then
      echo "$ITEM: TUN Condition --  WARNING"
    elif [[ "$log_check" == "CRITICAL" ]]; then
      echo "$ITEM: TUN Condition -- CRITICAL"
    else
      echo "$ITEM: Check tmp"
    fi
  fi
  # function returns:
  # TUN Conditon: OK or WARNING or CRITICAL
}




get_tun_arp() {
  # v3.sh is an expect script
  # logs into the router and returns tunnel status
  local get_arp=$(echo "$RTRO" | grep -i 'wan')
  local get_tun=$(grep -Eo 'NAME=(TUN..)|STATUS=(up|down)' <<< "$RTRO" | grep -v '-' | uniq | paste - -)
  echo "$get_tun"
  echo "$get_arp"
  # function returns:
  # NAME=TUN#      STATUS=up/down
  # NAME=TUN#      STATUS=up/down
  # NAME=TUN#      STATUS=up/down
  # NAME=TUN#      STATUS=up/down
  # NAME=TUN#      STATUS=up/down
  # NAME=TUN#      STATUS=up/down
  # NAME=TUN#      STATUS=up/down
  # NAME=TUN#      STATUS=up/down
  # NAME=TUN#      STATUS=up/down
  # NAME=TUN#      STATUS=up/down
  # IP         0          MAC wan1
  # IP         0          MAC wan2
}




# current_log
# count_sterm
# scurrent_log
# get_tun_arp
