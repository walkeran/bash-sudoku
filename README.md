# bash-sudoku
Sodoku puzzle solver written in bash using algorithms that humans would use. None of the algorithms (at this point) implement recursion, but the point is to build the algorithms to operate in the exact same way that I would personally solve puzzles.

## Yeah...
- I know it's written in BASH. Scoff if you will. I picked BASH because I felt like it
- I know it's terribly inefficient. That doesn't bother me too much. If I didn't have an extra 5 seconds to spend waiting for a puzzle solution, then I clearly wouldn't have had time to write this! :)
- I know there is a lot of room for error checking, tests, etc. I just took the easy route and assumed the user could follow instructions.
- I know "cube" is a stupid word for a 2-dimensional block of numbers. That was poor naming that stuck -- I'm aware that this is something that never happens in the IT industry, so I apologize!

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

## Example
Just an example of a run from start to finish, including building the structure (skel.sh), populating a puzzle (populate.sh), populating the value possibilities (rebuildposs.sh), and executing the algorithms (algo1.sh/algo2.sh). It also prints out the game board (print.sh) before and after running.
```
$ ./skel.sh 
Building cells...
Building rows...
Building columns...
Building cubes...
Done. Root of work dir is /tmp/sudoku.12353

$ work=/tmp/sudoku.12353          

$ ./populate.sh $work ex_extreme_1 

$ ./print.sh $work
    a   b   c   d   e   f   g   h   i
  +---+---+---+---+---+---+---+---+---+
1 |   |   | 3 | 6 |   | 8 |   |   | 9 |
  +---+---+---+---+---+---+---+---+---+
2 |   |   |   |   |   |   |   | 2 | 1 |
  +---+---+---+---+---+---+---+---+---+
3 |   |   |   |   |   |   |   |   |   |
  +---+---+---+---+---+---+---+---+---+
4 | 2 |   | 8 |   | 9 |   |   | 5 | 7 |
  +---+---+---+---+---+---+---+---+---+
5 |   |   | 6 |   | 2 |   | 8 |   |   |
  +---+---+---+---+---+---+---+---+---+
6 | 4 | 1 |   |   | 7 |   | 2 |   | 3 |
  +---+---+---+---+---+---+---+---+---+
7 |   |   |   |   |   |   |   |   |   |
  +---+---+---+---+---+---+---+---+---+
8 | 5 | 7 |   |   |   |   |   |   |   |
  +---+---+---+---+---+---+---+---+---+
9 | 8 |   |   | 3 |   | 4 | 6 |   |   |
  +---+---+---+---+---+---+---+---+---+

$ ./rebuildposs.sh $work
a1: 1     7  
b1:  2 45    
c1:           - 3
d1:           - 6
e1: 1  45    
f1:           - 8
g1:    45 7  
h1:    4  7  
i1:           - 9
a2:      67 9
b2:    456 89
c2:    45 7 9
d2:    45 7 9
e2:   345    
f2:   3 5 7 9
g2:   345 7  
h2:           - 2
i2:           - 1
a3: 1    67 9
b3:  2 456 89
c3: 12 45 7 9
d3: 12 45 7 9
e3: 1 345    
f3: 123 5 7 9
g3:   345 7  
h3:   34 678 
i3:    456 8 
a4:           - 2
b4:   3      
c4:           - 8
d4: 1  4     
e4:           - 9
f4: 1 3  6   
g4: 1  4     
h4:           - 5
i4:           - 7
a5:   3   7 9
b5:   3 5   9
c5:           - 6
d5: 1  45    
e5:           - 2
f5: 1 3 5    
g5:           - 8
h5: 1  4    9
i5:    4     
a6:           - 4
b6:           - 1
c6:     5   9
d6:     5  8 
e6:           - 7
f6:     56   
g6:           - 2
h6:      6  9
i6:           - 3
a7: 1 3  6  9
b7:  234 6  9
c7: 12 4    9
d7: 12  5 789
e7: 1   56 8 
f7: 12  567 9
g7: 1 345 7 9
h7: 1 34  789
i7:  2 45  8 
a8:           - 5
b8:           - 7
c8: 12 4    9
d8: 12     89
e8: 1    6 8 
f8: 12   6  9
g8: 1 34    9
h8: 1 34   89
i8:  2 4   8 
a9:           - 8
b9:  2      9
c9: 12      9
d9:           - 3
e9: 1   5    
f9:           - 4
g9:           - 6
h9: 1     7 9
i9:  2  5    

$ ./algo1.sh $work
b4 has one possibility. Using 3
i5 has one possibility. Using 4
Run #1 -- Previous: 25, New: 2
g4 has one possibility. Using 1
h5 has one possibility. Using 9
h6 has one possibility. Using 6
Run #2 -- Previous: 27, New: 3
d4 has one possibility. Using 4
f4 has one possibility. Using 6
a5 has one possibility. Using 7
b5 has one possibility. Using 5
d5 has one possibility. Using 1
f5 has one possibility. Using 3
c6 has one possibility. Using 9
f6 has one possibility. Using 5
Run #3 -- Previous: 30, New: 8
a1 has one possibility. Using 1
d6 has one possibility. Using 8
Run #4 -- Previous: 38, New: 2
Run #5 -- Previous: 40, New: 0

$ ./algo2.sh $work
b1 only cell in row with this possibility. Using 2
b2 only cell in row with this possibility. Using 8
i3 only cell in col with this possibility. Using 6
a7 only cell in col with this possibility. Using 3
b7 only cell in col with this possibility. Using 6
e8 only cell in row with this possibility. Using 6
b9 only cell in row with this possibility. Using 9
h9 only cell in row with this possibility. Using 7
Run #1 -- Previous: 40, New: 8
g1 only cell in row with this possibility. Using 7
a2 only cell in row with this possibility. Using 6
a3 only cell in col with this possibility. Using 9
b3 only cell in col with this possibility. Using 4
h3 only cell in row with this possibility. Using 8
e7 only cell in col with this possibility. Using 8
h8 only cell in col with this possibility. Using 3
i8 only cell in row with this possibility. Using 8
Run #2 -- Previous: 48, New: 8
e1 only cell in row with this possibility. Using 5
h1 only cell in row with this possibility. Using 4
e2 only cell in row with this possibility. Using 4
g2 only cell in row with this possibility. Using 3
e3 only cell in row with this possibility. Using 3
f3 only cell in row with this possibility. Using 1
g3 only cell in cube with this possibility. Using 5
d7 only cell in col with this possibility. Using 5
f7 only cell in row with this possibility. Using 7
g7 only cell in row with this possibility. Using 9
h7 only cell in col with this possibility. Using 1
c8 only cell in row with this possibility. Using 1
f8 only cell in col with this possibility. Using 2
g8 only cell in row with this possibility. Using 4
e9 only cell in row with this possibility. Using 1
i9 only cell in row with this possibility. Using 5
Run #3 -- Previous: 56, New: 16
c2 only cell in row with this possibility. Using 5
d2 only cell in row with this possibility. Using 7
f2 only cell in row with this possibility. Using 9
c3 only cell in row with this possibility. Using 7
d3 only cell in row with this possibility. Using 2
c7 only cell in row with this possibility. Using 4
i7 only cell in row with this possibility. Using 2
d8 only cell in row with this possibility. Using 9
c9 only cell in row with this possibility. Using 2
Run #4 -- Previous: 72, New: 9
Run #5 -- Previous: 81, New: 0

$ ./print.sh $work
    a   b   c   d   e   f   g   h   i
  +---+---+---+---+---+---+---+---+---+
1 | 1 | 2 | 3 | 6 | 5 | 8 | 7 | 4 | 9 |
  +---+---+---+---+---+---+---+---+---+
2 | 6 | 8 | 5 | 7 | 4 | 9 | 3 | 2 | 1 |
  +---+---+---+---+---+---+---+---+---+
3 | 9 | 4 | 7 | 2 | 3 | 1 | 5 | 8 | 6 |
  +---+---+---+---+---+---+---+---+---+
4 | 2 | 3 | 8 | 4 | 9 | 6 | 1 | 5 | 7 |
  +---+---+---+---+---+---+---+---+---+
5 | 7 | 5 | 6 | 1 | 2 | 3 | 8 | 9 | 4 |
  +---+---+---+---+---+---+---+---+---+
6 | 4 | 1 | 9 | 8 | 7 | 5 | 2 | 6 | 3 |
  +---+---+---+---+---+---+---+---+---+
7 | 3 | 6 | 4 | 5 | 8 | 7 | 9 | 1 | 2 |
  +---+---+---+---+---+---+---+---+---+
8 | 5 | 7 | 1 | 9 | 6 | 2 | 4 | 3 | 8 |
  +---+---+---+---+---+---+---+---+---+
9 | 8 | 9 | 2 | 3 | 1 | 4 | 6 | 7 | 5 |
  +---+---+---+---+---+---+---+---+---+
  ```
