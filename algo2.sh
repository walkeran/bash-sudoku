#!/bin/bash
WORK="$1"
txtgrn='\033[0;32m'
txtred='\033[0;31m'
txtrst='\033[0m'

if [[ ! -d "$WORK" ]] ; then
  echo "Work dir doesn't exist: $WORK"
  exit 5
fi

new=1 # Setting this before the loop isn't logical, but it works
run=0

while (( new > 0 )) ; do
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

      for area in row col cube; do
        for poss in $(cat $WORK/by-cell/$cell/poss) ; do
          possct=$(cat $WORK/by-cell/$cell/$area/*/poss | grep -c $poss)
          if (( possct == 1 )) ; then
            (( new++ ))
            echo -e "$cell only cell in $area with this possibility. Using ${txtgrn}${poss}${txtrst}"
            ./set.sh $WORK $cell $poss
            break 2
          fi
        done
      done
    done
  done
  echo "Run #${run} -- Previous: $prev, New: $new"
done
