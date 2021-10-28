CONST X_SIZE = 5
CONST Y_SIZE = 5

DO

  INPUT COMM$

  IF LEFT$(COMM$, 5) = "PLACE" THEN
    'Check that the command is of the correct structure
    IF (LEN(COMM$) <> 15 AND LEN(COMM$) <> 14) OR MID$(COMM$, 8, 1) <> ";" OR MID$(COMM$, 10, 1) <> ";" GOTO continue
    LET X_BUFFER = VAL(MID$(COMM$, 7, 1))
    LET Y_BUFFER = VAL(MID$(COMM$, 9, 1))
    LET FACING_BUFFER$ = MID$(COMM$, 11, 5)

    'Check that the position is valid
    IF X_BUFFER < 0 OR X_BUFFER > (X_SIZE - 1) OR Y_BUFFER < 0 OR Y_BUFFER > (Y_SIZE - 1) GOTO continue
    'Check that the direction is valid
    IF NOT (FACING_BUFFER$ = "NORTH" OR FACING_BUFFER$ = "SOUTH" OR FACING_BUFFER$ = "EAST" OR FACING_BUFFER$ = "WEST") GOTO continue

    LET X = X_BUFFER
    LET Y = Y_BUFFER
    LET FACING$ = FACING_BUFFER$

  ELSEIF COMM$ = "MOVE" THEN
    IF FACING$ = "NORTH" THEN
      IF Y < (Y_SIZE - 1) THEN
        LET Y = Y + 1
      END IF
    ELSEIF FACING$ = "SOUTH" THEN
      IF Y > 0 THEN
        LET Y = Y - 1
      END IF
    ELSEIF FACING$ = "EAST" THEN
      IF X < (X_SIZE - 1) THEN
        LET X = X + 1
      END IF
    ELSEIF FACING$ = "WEST" THEN
      IF X > 0 THEN
        LET X = X - 1
      END IF
    END IF

  ELSEIF COMM$ = "LEFT" THEN
    IF FACING$ = "NORTH" THEN
      LET FACING$ = "WEST"
    ELSEIF FACING$ = "SOUTH" THEN
      LET FACING$ = "EAST"
    ELSEIF FACING$ = "EAST" THEN
      LET FACING$ = "NORTH"
    ELSEIF FACING$ = "WEST" THEN
      LET FACING$ = "SOUTH"
    END IF

  ELSEIF COMM$ = "RIGHT" THEN
    IF FACING$ = "NORTH" THEN
      LET FACING$ = "EAST"
    ELSEIF FACING$ = "SOUTH" THEN
      LET FACING$ = "WEST"
    ELSEIF FACING$ = "EAST" THEN
      LET FACING$ = "SOUTH"
    ELSEIF FACING$ = "WEST" THEN
      LET FACING$ = "NORTH"
    END IF

  ELSEIF COMM$ = "REPORT" THEN
    IF FACING$ <> "" THEN
      PRINT X "," Y "," FACING$
    END IF

  END IF

continue:

LOOP WHILE COMM$ <> "QUIT"

END