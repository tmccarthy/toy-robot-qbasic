CONST TRUE = 1
CONST FALSE = 0

CONST X_SIZE = 5
CONST Y_SIZE = 5

CONST NORTH = "NORTH"
CONST SOUTH = "SOUTH"
CONST EAST = "EAST"
CONST WEST = "WEST"

CONST DIRECTION_LEFT = "LEFT"
CONST DIRECTION_RIGHT = "RIGHT"

TYPE POSITION
  x AS INTEGER
  y AS INTEGER
END TYPE

TYPE ROBOT
  placed AS INTEGER
  position AS POSITION
  facing AS STRING * 5
END TYPE

DIM robot AS ROBOT

DO

  DIM proposed_robot AS ROBOT

  LINE INPUT raw_command$

  IF is_place_command(raw_command$) THEN
    ROBOT_FROM_PLACE_COMMAND raw_command$, proposed_robot
  ELSE IF robot.placed THEN
    IF raw_command$ = "MOVE" THEN
      TRANSLATE robot.position, robot.facing, proposed_robot.position
    ELSE IF raw_command$ = "LEFT" THEN
      proposed_robot.facing = rotate$(robot.facing, DIRECTION_LEFT)
    ELSE IF raw_command$ = "RIGHT" THEN
      proposed_robot.facing = rotate$(robot.facing, DIRECTION_RIGHT)
    ELSE IF raw_command$ = "REPORT" THEN
      PRINT X "," Y "," FACING$
    END IF
  END IF

  IF is_within_bounds(proposed_robot.position) THEN
    robot = proposed_robot
  END IF

LOOP WHILE raw_command$ <> "QUIT"

END

FUNCTION is_place_command(raw_command$)

IF LEFT$(raw_command, 5) <> "PLACE"
  is_place_command = FALSE
  EXIT FUNCTION
END IF

IF (LEN(COMM$) <> 15 AND LEN(COMM$) <> 14) OR MID$(COMM$, 8, 1) <> ";" OR MID$(COMM$, 10, 1) <> ";"
  is_place_command = FALSE
  EXIT FUNCTION
END IF

direction_value = MID$(COMM$, 11, 5)

IF NOT (direction_value$ = NORTH OR direction_value$ = SOUTH OR direction_value$ = EAST OR direction_value$ = WEST)
  is_place_command = FALSE
  EXIT FUNCTION
END IF

is_place_command = TRUE

END FUNCTION

SUB ROBOT_FROM_PLACE_COMMAND (raw_place_command$, empty_robot AS ROBOT)

empty_robot.placed = TRUE
empty_robot.position.x = VAL(MID$(raw_command$, 7, 1))
empty_robot.position.y = VAL(MID$(COMM$, 9, 1))
empty_robot.facing = MID$(COMM$, 11, 5)

END SUB

FUNCTION is_within_bounds(position AS POSITION)

is_within_bounds = position.x >= 0 AND position.x < X_SIZE AND position.y >= 0 AND position.y < Y_SIZE

END FUNCTION

SUB TRANSLATE (position AS POSITION, direction$, empty_position AS POSITION)

IF direction$ = NORTH THEN
  empty_position.x = position.x
  empty_position.y = position.y + 1
ELSEIF direction$ = SOUTH THEN
  empty_position.x = position.x
  empty_position.y = position.y - 1
ELSEIF direction$ = EAST THEN
  empty_position.x = position.x + 1
  empty_position.y = position.y
ELSEIF direction$ = WEST THEN
  empty_position.x = position.x - 1
  empty_position.y = position.y
END IF

END SUB

FUNCTION rotate$(direction$, rotation$)

IF rotation$ = DIRECTION_LEFT THEN
  IF direction$ = NORTH THEN
    rotate$ = WEST
  ELSE IF direction$ = SOUTH THEN
    rotate$ = EAST
  ELSE IF direction$ = EAST THEN
    rotate$ = NORTH
  ELSE IF direction$ = WEST THEN
    rotate$ = SOUTH
  END IF
ELSE IF rotation = DIRECTION_RIGHT THEN
  IF direction$ = NORTH THEN
    rotate$ = WEST
  ELSE IF direction$ = SOUTH THEN
    rotate$ = EAST
  ELSE IF direction$ = EAST THEN
    rotate$ = NORTH
  ELSE IF direction$ = WEST THEN
    rotate$ = SOUTH
  END IF
END IF

END FUNCTION
