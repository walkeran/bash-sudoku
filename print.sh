#!/bin/bash
WORK=$1

if [[ ! -d "$WORK" ]] ; then
  echo "Work dir doesn't exist: $WORK"
  exit 7
fi

echo "    a   b   c   d   e   f   g   h   i"
echo "  +---+---+---+---+---+---+---+---+---+"
for row in {1..9} ; do
  echo -n "$row "
  for col in {a..i} ; do
    cell="${col}${row}"
    val=" "
    if [[ -f "$WORK/by-cell/$cell/val" ]] ; then
      val=$(cat "$WORK/by-cell/$cell/val")
    fi
    echo -n "| $val "
  done
  echo -e "|\n  +---+---+---+---+---+---+---+---+---+"
done
