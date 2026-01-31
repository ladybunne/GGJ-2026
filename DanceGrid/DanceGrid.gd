class_name DanceGrid

var cols : int
var rows : int

var dancerPairs : Array[DancerPair]

var patterns : Array[DancePattern]

const logIncomplete = true

func _init(_cols : int, _rows : int):
	cols = _cols
	rows = _rows
	dancerPairs.resize(cols * rows)

func GetPatternsFor(dancePos : Vector2i, direction : DancePattern.DanceDirection) -> Array[DancePattern]:
	var foundPatterns : Array[DancePattern]
	for pattern in patterns:
		var directionOnPattern = pattern.GetTowardDirectionAt(dancePos)
		if (directionOnPattern == direction):
			foundPatterns.append(pattern)
	return foundPatterns

func CheckCompleteAt(dancePos : Vector2i) -> bool:
	var complete = true;
	# var direction : DancePattern.DanceDirection
	for direction in DancePattern.DanceDirection.values():
		if (direction == DancePattern.DanceDirection.none):
			continue
		var directionOffset = DancePattern.DirectionOffsets[direction]
		var checkingToward = dancePos + directionOffset
		if (checkingToward.x < 0 || checkingToward.x >= cols || checkingToward.y < 0 || checkingToward.y >= rows):
			continue
		var foundPatterns = GetPatternsFor(dancePos, direction)
		if (foundPatterns.is_empty()):
			if (logIncomplete):
				print("Incomplete at: " + str(dancePos) + ", direction " + str(direction))
			complete = false
	return complete

func CheckComplete():
	var complete = true
	for row in range(rows):
		for col in range(cols):
			if (!CheckCompleteAt(Vector2i(col, row))):
				complete = false
	if (complete):
		print("Dance grid check passed, all points movable")
	return complete
