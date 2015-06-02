#!/bin/bash
WORK="$1"
txtgrn='\033[0;32m'
txtred='\033[0;31m'
txtrst='\033[0m'

if [[ ! -d "$WORK" ]] ; then
  echo "Work dir doesn't exist: $WORK"
  exit 5
fi

rm -f $WORK/by-cell/*/poss

# For each cell
for row in {1..9} ; do
  for col in {a..i} ; do
    cell="${col}${row}"
    output=""

    # Check if there's already a val there
    if [[ -f "$WORK/by-cell/${cell}/val" ]]; then
      echo "${cell}:           - $(cat $WORK/by-cell/${cell}/val)"
      continue
    fi

    # Loop over each possible cell vaue
    for i in {1..9}; do
      # And check to see if there is anything that matches that value in the
      #  cell's row, column, and cube.
      if grep -s -q $i $WORK/by-cell/${cell}/{row,col,cube}/*/val ; then
        # Matches were found -- can't use this number
        #output+="${txtred}${i}"
        output+=" "
      else
        # Nothing found in this cell's row/col/cube -- this number is a contender
        output+="${txtgrn}${i}"
        echo "$i" >> $WORK/by-cell/${cell}/poss
      fi
    done
    output+=$txtrst
    echo -e "${cell}: ${output}"
  done
done
