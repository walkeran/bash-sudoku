#!/bin/bash
WORK="$1"
txtgrn='\033[0;32m'
txtred='\033[0;31m'
txtrst='\033[0m'

if [[ ! -d "$WORK" ]] ; then
  echo "Work dir doesn't exist: $WORK"
  exit 5
fi

run=0

while : ; do
  prev=0   # previously set values
  new=0    # newly set values

  (( run++ ))
  # For each cell
  for row in {1..9} ; do
    for col in {a..i} ; do
      cell="${col}${row}"

      # Check if there's already a val there
      if [[ -f "$WORK/by-cell/${cell}/val" ]]; then
        (( prev++ ))
        continue
      fi

      possct=$(grep -c [0-9] $WORK/by-cell/${cell}/poss)

      if (( possct == 1 )) ; then
        (( new++ ))
        ## mv $WORK/by-cell/${cell}/{poss,val}
        # Remove value in $WORK/by-cell/${cell}/val from $WORK/by-cell/${cell}/{row,col,cube}/*/poss
        val=$(cat $WORK/by-cell/$cell/poss)
        echo -e "$cell has one possibility. Using ${txtgrn}${val}${txtrst}"
        ./set.sh $WORK $cell $val
      fi
    done
  done
  echo "Run #${run} -- Previous: $prev, New: $new"

  # If we didn't match anything new this run, or we're done, let's bail
  (( new == 0 || prev + new == 81  )) && break
done
