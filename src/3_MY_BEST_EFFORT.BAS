

CONST TRUE = 1
CONST FALSE = 0

CONST X_SIZE = 5
CONST Y_SIZE = 5

CONST NORTH = "NORTH"
CONST SOUTH = "SOUTH"
CONST EAST = "EAST"
CONST WEST = "WEST"

CONST LEFT = "LEFT"
CONST RIGHT = "RIGHT"

TYPE POSITION
  x AS INTEGER
  y AS INTEGER
END TYPE

TYPE ROBOT
  placed AS INTEGER
  position AS POSITION
  facing AS STRING * 5
END TYPE

FUNCTION translate(position, direction$)

DIM returned_position AS POSITION

IF direction$ = NORTH THEN
  returned_position.x = position.x
  returned_position.y = position.y + 1
ELSEIF direction$ = SOUTH THEN
  returned_position.x = position.x
  returned_position.y = position.y - 1
ELSEIF direction$ = EAST THEN
  returned_position.x = position.x + 1
  returned_position.y = position.y
ELSEIF direction$ = WEST THEN
  returned_position.x = position.x - 1
  returned_position.y = position.y
END IF

translate = returned_position

END FUNCTION

FUNCTION rotate$(direction$, rotation$)

IF rotation$ = LEFT THEN
  IF direction$ = NORTH THEN
    rotate$ = WEST
  ELSE IF direction$ = SOUTH THEN
    rotate$ = EAST
  ELSE IF direction$ = EAST THEN
    rotate$ = NORTH
  ELSE IF direction$ = WEST THEN
    rotate$ = SOUTH
  END IF
ELSE IF rotation = RIGHT THEN
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
