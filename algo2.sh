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

      # Check if there's already a val there. If there is, let's
      #  go to the next cell
      if [[ -f "$WORK/by-cell/${cell}/val" ]]; then
        (( prev++ ))
        continue
      fi

      # For each possible value of this cell
      for poss in $(cat $WORK/by-cell/$cell/poss) ; do
        # For each "group" (row, col, and cube) that this cell is a part of
        for group in row col cube; do
          # Determine how many times this possibility shows up in the group
          possct=$(cat $WORK/by-cell/$cell/$group/*/poss | grep -c $poss)
          # If the cell we're working on is the only occurrence, then let's set the value
          if (( possct == 1 )) ; then
            (( new++ ))
            echo -e "$cell only cell in $group with this possibility. Using ${txtgrn}${poss}${txtrst}"
            ./set.sh $WORK $cell $poss
            break 2
          fi
        done
      done
    done
  done
  echo "Run #${run} -- Previous: $prev, New: $new"

  # If we didn't match anything new this run, or we're done, let's bail
  (( new == 0 || prev + new == 81  )) && break
done
