### Project: 4 in a row.

This project aims to show how high-level C code interacts with low-level assembly language. This project simulates 4 in a Row with a CMD interface alternating between C and assembly subroutines.

1. C Implementation: Provides functional high-level implementation of the game logic.
2. Assembly Implementation: Mimics the C logic implementation at a lower level interacting with CPU instructions, memory management and control flow.

This project was done for the subject "Computer Architecture" to:

1. Understand Data Flow.
2. Memory management.
3. CMD interaction.

This project asks the student to define the low-level subroutines in Assembly mimicking the C subroutines defined in the `Part1.c` file used as guidance. For part one the student must define:

1. calcIndexP1
2. updateBoard P1
3. moveCursorP1
4. checkEndP1

##### Test the implementation

To test the implementation in Assembly comment out the corresponding C Function. For example in `Part1.c` file go to Line 630, comment out `calcIndexP1();` and comment `calcIndexP1_C();`. This will activate your Assembly implementation and comment the C implementation. It should look something like this:

```
        //=======================================================
        calcIndexP1();
        //calcIndexP1_C();
        //=======================================================
```
