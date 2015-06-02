#!/bin/bash
WORK="$1"
txtgrn='\033[0;32m'
txtred='\033[0;31m'
txtrst='\033[0m'

if [[ ! -d "$WORK" ]] ; then
  echo "Work dir doesn't exist: $WORK"
  exit 5
fi

# For each cell
for row in {1..9} ; do
  for col in {a..i} ; do
    cell="${col}${row}"
    output=""
    croot=$WORK/by-cell/${cell}

    # Check if there's already a val there
    if [[ -f "$croot/val" ]]; then
      rm -f $croot/poss
      continue
    fi

    grep -f <(cat $croot/row/*/val $croot/col/*/val $croot/cube/*/val | sort | uniq) -v $croot/poss > $croot/poss.tmp
    mv $croot/poss{.tmp,}

  done
done
