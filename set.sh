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

# Get rid of the possibilities
rm -f $WORK/by-cell/$cell/poss

# Set the value
echo "$val" > $WORK/by-cell/$cell/val

# Filter this value out of the possibilities for all of the siblings of this cell
# find - 'poss' files (name), that are direct relatives (min/maxdepth)
# xargs sed - for each file (-L), edit in place (-i), and remove any line that matches the value
find -L $WORK/by-cell/$cell/ -maxdepth 3 -mindepth 2 -name poss 2> /dev/null | xargs -L 1 sed -i "/^$val\$/d" 2> /dev/null
