#!/bin/bash
WORK="$1"
cell="$2"
val="$3"

if ! [[ -d "$WORK" ]] ; then
  echo "Work dir doesn't exist: $WORK"
  exit 5
fi

if ! [[ -d "$WORK/by-cell/$cell" ]] ; then
  echo "Cell dir doesn't exist: $WORK/by-cell/$cell"
  exit 6
fi

if [[ -f "$WORK/by-cell/val" ]] ; then
  echo "Can't set value for cell: $cell; value already set"
  exit 7
fi

if ! [[ $val =~ ^[1-9]$ ]] ; then
  echo "Not a valid value: $val"
  exit 8
fi

rm -f $WORK/by-cell/$cell/poss

echo "$val" > $WORK/by-cell/$cell/val

find -L $WORK/by-cell/$cell/ -maxdepth 3 -mindepth 2 -name poss 2> /dev/null | xargs -L 1 sed -i "/^$val\$/d" 2> /dev/null
