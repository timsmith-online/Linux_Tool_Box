#!/bin/bash
# Show progress
progress(){
  echo -n "$0: Please wait..."
  while true
  do
    echo -n "."
    sleep 5
  done
}
dosomething(){
  sleep 11; echo -n "x"
}
# Start it in the background
progress &
# Save progress() PID
# Use the PID to kill the function
MYSELF=$!
dosomething

# Kill progress
kill $MYSELF >/dev/null 2>&1

echo -n "...done."
