
# Conway's Game of Life
![](pics/Gospers_glider_gun.gif)


The Game of Life, also known simply as Life, is a cellular automaton devised by the British mathematician John Horton Conway in 1970. It is a zero-player game, meaning that its evolution is determined by its initial state, requiring no further input. One interacts with the Game of Life by creating an initial configuration and observing how it evolves. It is Turing complete and can simulate a universal constructor or any other Turing machine.

Rules
-------------
The universe of the Game of Life is an infinite(in this specific implementation it is 10*10), two-dimensional orthogonal grid of square cells, each of which is in one of two possible states, live or dead (or populated and unpopulated, respectively). Every cell interacts with its eight neighbours, which are the cells that are horizontally, vertically, or diagonally adjacent. At each step in time, the following transitions occur:

Any live cell with fewer than two live neighbours dies, as if by underpopulation.
Any live cell with two or three live neighbours lives on to the next generation.
Any live cell with more than three live neighbours dies, as if by overpopulation.
Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.

These rules, which compare the behavior of the automaton to real life, can be condensed into the following:

Any live cell with two or three live neighbours survives.
Any dead cell with three live neighbours becomes a live cell.
All other live cells die in the next generation. Similarly, all other dead cells stay dead.
The initial pattern constitutes the seed of the system. The first generation is created by applying the above rules simultaneously to every cell in the seed, live or dead; births and deaths occur simultaneously, and the discrete moment at which this happens is sometimes called a tick.  Each generation is a pure function of the preceding one. The rules continue to be applied repeatedly to create further generations.

### Example Of Patterns
                
![Patterns in Game Of Life](pics/4life2.png)

# Installation
Installation for the programming environment of antique languages is not easy. We will specify below. 
## BASIC
Utilize the [FreeBASIC](https://sourceforge.net/projects/fbc/files/FreeBASIC-1.10.1/) tool. Notice that it cannot be used in MacOS system and your best choice is Unix. Installation to Ununtu 22.04 is specified:
#### Download the cooresponding package:
Go to this web page to download [FreeBASIC-1.10.1-ubuntu-22.04-x86_64.tar.gz](http://downloads.sourceforge.net/fbc/FreeBASIC-1.10.1-ubuntu-22.04-x86_64.tar.gz?download). 

#### Unpackage
```
tar -xf FreeBASIC-1.10.1-ubuntu-22.04-x86_64.tar
```

#### Install 
```
cd FreeBASIC-1.10.1-ubuntu-22.04-x86_64 
sudo ./install.sh -i
```
#### Verify installation
```
fbc --version
```

#### Code and run
```
nano example.bas #add code in the editer
fbc example.bas
./example
```
## COBOL
The gnuCOBOL project is the easiest way to get COBOL up an running on Linux or macOS:
#### Install gnu-cobol:
```
sudo apt install gnu-cobol
```

#### Compile and run
```
cobc -x game_of_life.cbl -free
./game_of_life
```

