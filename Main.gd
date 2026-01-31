extends Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Welcome to Global Game Jam 2026!")
	
	# Test stuff
	var danceGrid = DanceGrid.new(4, 4);
	
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
		layout = layout.remove_chars('\n\t')
		#layout.replace("\n", "")
		#layout.replace("\t", "")
		var customPatternDancePattern = DancePattern.new(danceGrid.cols, danceGrid.rows)
		for i in range(layout.length()):
			var number = int(layout[i])
			if (number == 1):
				number = 3
			elif (number == 3):
				number = 1
			var direction : DancePattern.DanceDirection = number
			var dancePos : Vector2i = GridUtils.IndexOf2DFrom1D(danceGrid.cols, i)
			customPatternDancePattern.SetAt(dancePos, direction)
		danceGrid.patterns.append(customPatternDancePattern)


	danceGrid.CheckComplete();


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
