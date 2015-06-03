# bash-sudoku
Sodoku puzzle solver written in bash using algorithms that humans would use. None of the algorithms (at this point) implement recursion, but the point is to build the algorithms to operate in the exact same way that I would personally solve puzzles.

## Yeah...
- I know it's written in BASH. Scoff if you will. I picked BASH because I felt like it
- I know it's terribly inefficient. That doesn't bother me too much. If I didn't have an extra 5 seconds to spend waiting for a puzzle solution, then I clearly wouldn't have had time to write this! :)
- I know there is a lot of room for error checking, tests, etc. I just took the easy route and assumed the user could follow instructions.
- I know "cube" is a stupid word for a 2-dimensional block of numbers. That was poor naming that stuck -- I know, this is something that never happens in the IT industry, so I apologize!

## Files
### Puzzle initialization scripts
- **skel.sh** - Create a skeleton directory structure under /tmp and print out the path
- **populate.sh** - Populate the directory structure with initial puzzle values
- **rebuildposs.sh** - Builds a list of possibile values for each cell, and includes those in the directory structure

### Algorithm scripts
- **algo1.sh** - Completes cells that only have one possibility
- **algo2.sh** - Completes cells that are the only cell in the same row, cell, or "cube" that have a specific possibility

### Worthless scripts
- **filterposs.sh** - This isn't necessarily worthless, but at this point, it's not necessary for any of the algorithms. This will go through each cell that has a value, and make sure none of the related cells (same row, col, cube) contain that value as a possibility. This was useful during early-on testing, and I figured it might be useful in the future, so it remains.

### Other scripts
- **print.sh** - Will print out a purdy sudoku board including all values (initial, and ones that have been solved so far)
- **set.sh** - Quick utility for setting the value of a cell. The most important function is that it cleans up -- it removes the possibilities for that cell, and it also removes the value from the relative cells' possibilities. Algorithms should use this when setting a value.

### Example puzzle inputs
There are a handful of example puzzle boards with names like `ex_hard_1`. Props to the authors of the [Sudoku Free](https://play.google.com/store/apps/details?id=com.icenta.sudoku.ui&hl=en) Android app, which is where I lifted these few examples from.

## Caveats
- rebuildposs.sh must be run prior to the algorithms at this point. Algo #1 and #2 both expect all of the possibilities files to be populated
- set.sh doesn't confirm that it's legal to set the value (although, it does at least make sure it's a number between 1 and 9!)
- There are no warnings if a puzzle ends up in an unsolvable state. No warnings for puzzles that these specific algos can't solve, and no warnings for a puzzle that ends up in a weird state that causes it to be literally impossible to finish.
- populate.sh is pretty picky, and doesn't complain if you give it a malformed input file. It expects exactly 9 lines with exactly 9 characters (plus a newline) per line. Restated, each input file should contain exactly 90 characters, 9 of which are newlines. Empty cells are to be represented by spaces.
