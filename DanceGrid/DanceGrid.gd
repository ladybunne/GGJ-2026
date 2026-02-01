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
	
	if (cols == 4 && rows == 4):
		SetUp4x4Grid();

	CheckComplete();

func SetUp4x4Grid() -> void:
	var gridLayouts : Array[String]
	gridLayouts.append("
	2	2	2	3
	1	2	3	3
	1	1	4	3
	1	4	4	4
	")
	gridLayouts.append("
	3	4	4	4
	3	3	4	1
	3	2	1	1
	2	2	2	1
	")
	gridLayouts.append("
	3	3	3	3
	1	1	1	1
	3	3	3	3
	1	1	1	1
	")
	gridLayouts.append("
	2	4	2	4
	2	4	2	4
	2	4	2	4
	2	4	2	4
	")
	gridLayouts.append("
	2	4	2	4
	3	3	3	3
	1	1	1	1
	2	4	2	4
	")
	gridLayouts.append("
	3	2	4	3
	1	2	4	1
	3	2	4	3
	1	2	4	1
	")
	for layout in gridLayouts:
		AddPatternByString(layout)

func AddPatternByString(patternAsString : String):
	patternAsString = patternAsString.remove_chars('\n\t')
	var customPatternDancePattern = DancePattern.new(cols, rows)
	for i in range(patternAsString.length()):
		var number = int(patternAsString[i])
		if (number == int(DancePattern.DanceDirection.up)):
			number = int(DancePattern.DanceDirection.down)
		elif (number == int(DancePattern.DanceDirection.down)):
			number = int(DancePattern.DanceDirection.up)
		var direction : DancePattern.DanceDirection = number
		var dancePos : Vector2i = GridUtils.IndexOf2DFrom1D(cols, i)
		customPatternDancePattern.SetAt(dancePos, direction)
	patterns.append(customPatternDancePattern)

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
				printerr("Incomplete at: " + str(dancePos) + ", direction " + str(direction))
			complete = false
	return complete

func CheckComplete():
	var complete = true
	for row in range(rows):
		for col in range(cols):
			if (!CheckCompleteAt(Vector2i(col, row))):
				complete = false
	if (complete):
		print("Dance grid check passed, all points movable :)")
	return complete
