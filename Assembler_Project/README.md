### Project: 4 in a row.

This project aims to show how high-level C code interacts with low-level `x86_64` architecture assembly language. This project is more than just a game, it is a hands-on dive into the gap between software and hardware. This project simulates 4 in a Row with a CMD interface alternating between C and assembly subroutines.

1. C Implementation: Provides functional high-level implementation of the game logic.
2. Assembly Implementation: Mimics the C logic implementation at a lower level interacting with CPU instructions, memory management and control flow.

This project was done for the subject "Computer Architecture" to:

1. Understand Data Flow, I/O control flow.
2. Memory management (Use relative and indexed addressing to interact with matrices and arrays in memory).
3. CMD interaction.
4. Gain experience in low-level programming, debugging and Assembly code.

This project asks the student to define the low-level subroutines in Assembly mimicking the C subroutines defined in the `Part1.c` file used as guidance. 

#### Part 1: Core Functionality:

The main objectives of part one include:

1. Dropping discs into columns with gravity.
2. Checking if the board is full.

For part one the student must define:

1. calcIndexP1
2. updateBoard P1
3. showDiscPosP1
4. moveCursorP1
5. insertDiscP1
6. checkEndP1

#### Part 2: Winning condition:

Part two of the project extends functionality to detect a winner by checking for 4 connected discs in horizontal, vertical, or diagonal lines. The subroutine to define is:

1. calcIndexP2
2. updateBoardP2
3. checkLineP2

##### Test the implementation

To test the implementation in Assembly comment out the corresponding C Function. For example in `Part1.c` file go to Line 630, comment out `calcIndexP1();` and comment `calcIndexP1_C();`. This will activate your Assembly implementation and comment the C implementation. It should look something like this:

```
        //=======================================================
        calcIndexP1();
        //calcIndexP1_C();
        //=======================================================
```

#### Running the program

To run the program you first need to compile it. To compile you need a compatible compiler to build the program. Run:

```
gcc -o game Part1.c Part1_Assembler.o
```
