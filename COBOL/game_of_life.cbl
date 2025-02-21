       IDENTIFICATION DIVISION.
       PROGRAM-ID. GAMEOFLIFE.
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01 GRID-SIZE       PIC 99 VALUE 10.
       01 GENERATIONS    PIC 99 VALUE 10.
       01 GRID.
          05 ROW OCCURS 10 INDEXED BY I.
             10 CELL OCCURS 10 PIC 9 INDEXED BY J.
       01 TEMP-GRID.
          05 TEMP-ROW OCCURS 10 INDEXED BY TI.
             10 TEMP-CELL OCCURS 10 PIC 9 INDEXED BY TJ.
       01 NEIGHBORS      PIC 99.
       01 X              PIC 99.
       01 Y              PIC 99.

       PROCEDURE DIVISION.
       MAIN-PROCEDURE.
           PERFORM INITIALIZE-GRID.
           PERFORM PRINT-GRID.
           PERFORM VARYING X FROM 1 BY 1 UNTIL X > GENERATIONS
               PERFORM UPDATE-GRID
               PERFORM PRINT-GRID
           END-PERFORM.
           STOP RUN.

       INITIALIZE-GRID.
           MOVE 0 TO GRID.
           MOVE 1 TO GRID (5,5), GRID (5,6), GRID (5,4).

       PRINT-GRID.
           DISPLAY "Current Generation:".
           PERFORM VARYING I FROM 1 BY 1 UNTIL I > GRID-SIZE
               PERFORM VARYING J FROM 1 BY 1 UNTIL J > GRID-SIZE
                   IF GRID (I, J) = 1
                       DISPLAY "#" WITH NO ADVANCING
                   ELSE
                       DISPLAY "." WITH NO ADVANCING
                   END-IF
               END-PERFORM
               DISPLAY ""
           END-PERFORM.

       UPDATE-GRID.
           MOVE GRID TO TEMP-GRID.
           PERFORM VARYING I FROM 1 BY 1 UNTIL I > GRID-SIZE
               PERFORM VARYING J FROM 1 BY 1 UNTIL J > GRID-SIZE
                   MOVE 0 TO NEIGHBORS
                   PERFORM COUNT-NEIGHBORS
                   IF GRID (I, J) = 1
                       IF NEIGHBORS < 2 OR NEIGHBORS > 3
                           MOVE 0 TO TEMP-GRID (I, J)
                       ELSE
                           MOVE 1 TO TEMP-GRID (I, J)
                       END-IF
                   ELSE
                       IF NEIGHBORS = 3
                           MOVE 1 TO TEMP-GRID (I, J)
                       END-IF
                   END-IF
               END-PERFORM
           END-PERFORM.
           MOVE TEMP-GRID TO GRID.

       COUNT-NEIGHBORS.
           MOVE 0 TO NEIGHBORS.
           PERFORM VARYING TI FROM I - 1 BY 1 UNTIL TI > I + 1
               PERFORM VARYING TJ FROM J - 1 BY 1 UNTIL TJ > J + 1
                   IF TI > 0 AND TI <= GRID-SIZE AND
                      TJ > 0 AND TJ <= GRID-SIZE AND
                      NOT (TI = I AND TJ = J)
                      IF GRID (TI, TJ) = 1
                          ADD 1 TO NEIGHBORS
                      END-IF
                   END-IF
               END-PERFORM
           END-PERFORM.

