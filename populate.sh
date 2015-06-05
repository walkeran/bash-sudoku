#!/bin/bash
WORK=$1
INFILE=$2

if [[ ! -f "$INFILE" ]] ; then
  echo "Infile doesn't exist: $INFILE"
  exit 6
fi

if [[ ! -d "$WORK" ]] ; then
  echo "Work dir doesn't exist: $WORK"
  exit 7
fi

# Open infile as fd3
exec 3< $INFILE

# For each cell
for row in {1..9} ; do
  for col in {a..i} ; do
    cell="${col}${row}"

    # Read a value, and dump it into the puzzle
    read -u 3 -r -n 1 val
    if [[ "$val" =~ [0-9] ]]; then
      echo "${val}" > $WORK/by-cell/$cell/val
    fi
  done

  # At the end of the row, pop off the newline
  read -u 3 -r -n 1
done

# Closing time!
exec 3<&-
