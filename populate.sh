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

exec 3< $INFILE

for row in {1..9} ; do
  for col in {a..i} ; do
    cell="${col}${row}"
    read -u 3 -r -n 1 val
    if [[ "$val" =~ [0-9] ]]; then
      echo "${val}" > $WORK/by-cell/$cell/val
    fi
  done
  read -u 3 -r -n 1
done

exec 3<&-
