        IDENTIFICATION DIVISION.
        PROGRAM-ID. GAMEOFLIFE.
        ENVIRONMENT DIVISION.
        INPUT-OUTPUT SECTION.
        FILE-CONTROL.
                SELECT INPUT-FILE ASSIGN TO "../start.txt"
                        ORGANIZATION IS LINE SEQUENTIAL.
        DATA DIVISION.
                FILE SECTION.
                        FD INPUT-FILE.
                                01 INPUT-CHAR PIC X.

                WORKING-STORAGE SECTION.
                        01 POS USAGE INDEX.
                        01 GRID-CURRENT.
                                05 CUR PIC 9 VALUE 0 OCCURS 10000 TIMES.
                        01 GRID-BUF.
                                05 BUF PIC 9 VALUE 0 OCCURS 10000 TIMES.
                        01 NUM-ITER PIC 9(5) VALUE 1000.
                        01 CUR-ITER USAGE INDEX.
                        01 I USAGE INDEX.
                        01 J USAGE INDEX.
                        01 I-ADJ PIC 9.
                        01 J-ADJ PIC 9.
                        01 I-MOD PIC 9.
                        01 J-MOD PIC 9.
                        01 I-DIV PIC 9.
                        01 J-DIV PIC 9.
                        01 IDX USAGE INDEX.
                        01 NEIGHBOR-SUM PIC 9.
                        01 VAL PIC 9.
                        01 CELL-VALUE PIC 9.
                        01 NEIGHBOR-1 USAGE INDEX.
                        01 NEIGHBOR-2 USAGE INDEX.
                        01 NEIGHBOR-3 USAGE INDEX.
                        01 NEIGHBOR-4 USAGE INDEX.
                        01 NEIGHBOR-5 USAGE INDEX.
                        01 NEIGHBOR-6 USAGE INDEX.
                        01 NEIGHBOR-7 USAGE INDEX.
                        01 NEIGHBOR-8 USAGE INDEX.

        PROCEDURE DIVISION.
                OPEN INPUT INPUT-FILE.

                PERFORM UNTIL POS = 10000
                        READ INPUT-FILE INTO INPUT-CHAR
                        END-READ

                        IF INPUT-CHAR NOT = ' ' 
                            MOVE INPUT-CHAR TO CUR(POS)
                            ADD 1 TO POS
                        END-IF

                END-PERFORM.

                CLOSE INPUT-FILE.

                PERFORM UNTIL CUR-ITER = NUM-ITER
                        PERFORM UNTIL I = 100
                                PERFORM UNTIL J = 100
                                        MOVE 0 TO NEIGHBOR-SUM
                                        COMPUTE IDX = I * 100 + J
                                        MOVE CUR(IDX) TO CELL-VALUE

                                        COMPUTE I-ADJ = I - 1
                                        COMPUTE J-ADJ = J - 1

                                        DIVIDE I-ADJ BY 100 GIVING I-DIV REMAINDER I-MOD
                                        DIVIDE J-ADJ BY 100 GIVING J-DIV REMAINDER J-MOD

                                        COMPUTE NEIGHBOR-1 = I-MOD * 100 + J-MOD

                                        COMPUTE J-ADJ = J - 1

                                        DIVIDE J-ADJ BY 100 GIVING J-DIV REMAINDER J-MOD

                                        COMPUTE NEIGHBOR-2 = I * 100 + J-MOD

                                        COMPUTE I-ADJ = I + 1
                                        COMPUTE J-ADJ = J - 1

                                        DIVIDE I-ADJ BY 100 GIVING I-DIV REMAINDER I-MOD
                                        DIVIDE J-ADJ BY 100 GIVING J-DIV REMAINDER J-MOD

                                        COMPUTE NEIGHBOR-3 = I-MOD * 100 + J-MOD

                                        COMPUTE I-ADJ = I - 1
                                        COMPUTE J-ADJ = J + 1

                                        DIVIDE I-ADJ BY 100 GIVING I-DIV REMAINDER I-MOD
                                        DIVIDE J-ADJ BY 100 GIVING J-DIV REMAINDER J-MOD

                                        COMPUTE NEIGHBOR-4 = I-MOD * 100 + J-MOD

                                        COMPUTE J-ADJ = J + 1

                                        DIVIDE J-ADJ BY 100 GIVING J-DIV REMAINDER J-MOD

                                        COMPUTE NEIGHBOR-5 = I * 100 + J-MOD

                                        COMPUTE I-ADJ = I + 1
                                        COMPUTE J-ADJ = J + 1

                                        DIVIDE I-ADJ BY 100 GIVING I-DIV REMAINDER I-MOD
                                        DIVIDE J-ADJ BY 100 GIVING J-DIV REMAINDER J-MOD

                                        COMPUTE NEIGHBOR-6 = I-MOD * 100 + J-MOD

                                        COMPUTE I-ADJ = I + 1

                                        DIVIDE I-ADJ BY 100 GIVING I-DIV REMAINDER I-MOD

                                        COMPUTE NEIGHBOR-7 = I-MOD * 100 + J

                                        COMPUTE I-ADJ = I - 1

                                        DIVIDE I-ADJ BY 100 GIVING I-DIV REMAINDER I-MOD

                                        COMPUTE NEIGHBOR-8 = I-MOD * 100 + J

                                        MOVE CUR(NEIGHBOR-1) TO VAL
                                        ADD VAL TO NEIGHBOR-SUM

                                        MOVE CUR(NEIGHBOR-2) TO VAL
                                        ADD VAL TO NEIGHBOR-SUM

                                        MOVE CUR(NEIGHBOR-3) TO VAL
                                        ADD VAL TO NEIGHBOR-SUM

                                        MOVE CUR(NEIGHBOR-4) TO VAL
                                        ADD VAL TO NEIGHBOR-SUM

                                        MOVE CUR(NEIGHBOR-5) TO VAL
                                        ADD VAL TO NEIGHBOR-SUM

                                        MOVE CUR(NEIGHBOR-6) TO VAL
                                        ADD VAL TO NEIGHBOR-SUM

                                        MOVE CUR(NEIGHBOR-7) TO VAL
                                        ADD VAL TO NEIGHBOR-SUM

                                        MOVE CUR(NEIGHBOR-8) TO VAL
                                        ADD VAL TO NEIGHBOR-SUM

                                        IF (NEIGHBOR-SUM = 3 AND (CELL-VALUE = 0))
                                                MOVE 1 TO VAL
                                        ELSE
                                                IF CELL-VALUE = 1 AND (NEIGHBOR-SUM = 2 OR NEIGHBOR-SUM = 3) THEN
                                                        MOVE 1 TO BUF(idx)
                                                ELSE
                                                        MOVE 0 TO BUF(idx)
                                                END-IF
                                        END-IF

                                        MOVE VAL TO BUF(IDX)

                                        ADD 1 to J 
                                END-PERFORM
                                SET J TO 0
                                ADD 1 to I
                        END-PERFORM
                        SET I TO 0
                        MOVE GRID-BUF TO GRID-CURRENT
                        ADD 1 TO CUR-ITER
                END-PERFORM.

                STOP RUN.

