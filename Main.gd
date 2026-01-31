extends Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Welcome to Global Game Jam 2026!")
	
	# Test stuff
	var danceGrid = DanceGrid.new(2, 2);
	
	var customClockwisePattern = DancePattern.new(danceGrid.cols, danceGrid.rows)
	
	customClockwisePattern.SetAt(Vector2i(0, 0), DancePattern.DanceDirection.up)
	customClockwisePattern.SetAt(Vector2i(0, 1), DancePattern.DanceDirection.right)
	customClockwisePattern.SetAt(Vector2i(1, 1), DancePattern.DanceDirection.down)
	customClockwisePattern.SetAt(Vector2i(1, 0), DancePattern.DanceDirection.left)
	
	var customAntiClockwisePattern = DancePattern.new(danceGrid.cols, danceGrid.rows)
	
	customAntiClockwisePattern.SetAt(Vector2i(0, 0), DancePattern.DanceDirection.right)
	customAntiClockwisePattern.SetAt(Vector2i(1, 0), DancePattern.DanceDirection.up)
	customAntiClockwisePattern.SetAt(Vector2i(1, 1), DancePattern.DanceDirection.left)
	customAntiClockwisePattern.SetAt(Vector2i(0, 1), DancePattern.DanceDirection.down)
	
	danceGrid.patterns.append(customClockwisePattern)
	danceGrid.patterns.append(customAntiClockwisePattern)
	
	danceGrid.CheckComplete();


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
