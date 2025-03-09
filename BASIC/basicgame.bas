DIM SHARED grid(100, 100) AS INTEGER
DIM SHARED new_grid(100, 100) AS INTEGER
DIM SHARED states(2000, 100, 100) AS INTEGER

SUB read_initial_state(file_path AS STRING, rows AS INTEGER, cols AS INTEGER)
    DIM i AS INTEGER, j AS INTEGER
    OPEN file_path FOR INPUT AS #1
    FOR i = 1 TO rows
        FOR j = 1 TO cols
            INPUT #1, grid(i, j)
        NEXT j
    NEXT i
    CLOSE #1
END SUB

SUB get_next_state(rows AS INTEGER, cols AS INTEGER)
    DIM i AS INTEGER, j AS INTEGER, x AS INTEGER, y AS INTEGER, neighbors AS INTEGER
    FOR i = 1 TO rows
        FOR j = 1 TO cols
            neighbors = 0
            FOR x = -1 TO 1
                FOR y = -1 TO 1
                    IF x <> 0 OR y <> 0 THEN
                        neighbors = neighbors + grid((i + x - 1 + rows) MOD rows + 1, (j + y - 1 + cols) MOD cols + 1)
                    END IF
                NEXT y
            NEXT x

            IF grid(i, j) = 1 THEN
                IF neighbors = 2 OR neighbors = 3 THEN
                    new_grid(i, j) = 1
                ELSE
                    new_grid(i, j) = 0
                END IF
            ELSE
                IF neighbors = 3 THEN
                    new_grid(i, j) = 1
                ELSE
                    new_grid(i, j) = 0
                END IF
            END IF
        NEXT j
    NEXT i

    FOR i = 1 TO rows
        FOR j = 1 TO cols
            grid(i, j) = new_grid(i, j)
        NEXT j
    NEXT i
END SUB

SUB save_states(num_iter AS INTEGER, rows AS INTEGER, cols AS INTEGER)
    DIM k AS INTEGER, i AS INTEGER, j AS INTEGER
    OPEN "out/record.txt" FOR OUTPUT AS #2
    FOR k = 1 TO num_iter
        FOR i = 1 TO rows
            FOR j = 1 TO cols
                PRINT #2, states(k, i, j); " ";
            NEXT j
            PRINT #2,
        NEXT i
        PRINT #2,
    NEXT k
    CLOSE #2
END SUB

SUB game_of_life(file_path AS STRING, num_iter AS INTEGER, rows AS INTEGER, cols AS INTEGER)
    DIM k AS INTEGER, i AS INTEGER, j AS INTEGER
    read_initial_state(file_path, rows, cols)
    FOR k = 1 TO num_iter
        get_next_state(rows, cols)
        FOR i = 1 TO rows
            FOR j = 1 TO cols
                states(k, i, j) = grid(i, j)
            NEXT j
        NEXT i
    NEXT k
    save_states(num_iter, rows, cols)
END SUB

DIM file_path AS STRING
DIM num_iter AS INTEGER
DIM rows AS INTEGER
DIM cols AS INTEGER

file_path = "./antique-game-of-life/start.txt"
num_iter = 2000
rows = 100
cols = 100

game_of_life(file_path, num_iter, rows, cols)
