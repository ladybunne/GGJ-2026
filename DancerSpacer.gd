extends Node

@export var gridCols : int;
@export var gridRows : int;

@export var widthBetweenPairs : float
@export var heightBetweenPairs : float

@export var dancerBetweenSpacing : float

# In seconds, how long does it take to get to new position
@export var timeToMove : float
@export var timeToDance : float

@export var playerMovement : DancePattern.DanceDirection
@export var playerChildIndex : int

var dancers;

var fromWorldPositions : Array[Vector3]
var toWorldPositions : Array[Vector3]

var fromDancePositions : Array[Vector2i]
var toDancePositions : Array[Vector2i]

# If not moving, should be dancing
var currentlyMoving : bool

var timer : float

var danceGrid : DanceGrid

#var clockTime : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dancers = get_children()

	fromDancePositions.resize(dancers.size())
	toDancePositions.resize(dancers.size())
	fromDancePositions.resize(dancers.size())
	toDancePositions.resize(dancers.size())
	
	danceGrid = DanceGrid.new(4, 4);
	
	timer = timeToDance
	currentlyMoving = false

	ArrangeIntoPositions()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#clockTime += 
	timer -= delta
	
	if (currentlyMoving):
		var lerpPercent : float
		if (timer > 0.0):
			lerpPercent = -timer / timeToMove
		else:
			currentlyMoving = false
			# Plus the timer to ensure there isn't "leftover time", in consideration of syncing the music
			timer = timeToDance + timer
			lerpPercent = 0.0
			fromWorldPositions = toWorldPositions.duplicate()
			fromDancePositions = toDancePositions.duplicate()
			# new positions will be calulated when switching back to move
		for i : int in(dancers.size()):
			var dancer = dancers[i]
			var newPos = lerp(fromWorldPositions[i], toWorldPositions[i], lerpPercent)
			dancer.transform.origin = newPos
	else: # Currently dancing
		if (timer <= 0.0):
			currentlyMoving = true
			timer = timeToMove + timer
			# Get new dance positions
			var playerDancePos = toDancePositions[playerChildIndex]
			var patterns = danceGrid.GetPatternsFor(playerDancePos, playerMovement)
			# should be a random one that is avalible, will just do the first one for now
			var pattern = patterns[0]
			for i : int in dancers.size():
				var direction = pattern.GetTowardDirectionAt(toDancePositions[i])
				toDancePositions[i] = DancePattern.DirectionOffsets[direction]
			
func DancePosToWorld(dancePos : Vector2i, first : bool) -> Vector3:
	var halfTotalWidth : float = widthBetweenPairs * (gridCols - 1) / 2.0
	var halfTotalHeight : float = heightBetweenPairs * (gridRows - 1) / 2.0
	var x : float = widthBetweenPairs * dancePos.x
	if (first):
		x += dancerBetweenSpacing / 2.0
	else:
		x -= dancerBetweenSpacing / 2.0
	var z : float = heightBetweenPairs * dancePos.y
	x -= halfTotalWidth
	z -= halfTotalHeight
	return Vector3(x, 0.0, z);
	

func ArrangeIntoPositions() -> void:
	for i : int in(dancers.size()):
		var col : int = (i / 2)  % gridCols
		var row : int = (i / 2) / gridCols
		var first : bool = i % 2 == 1;
		var worldPos = DancePosToWorld(Vector2i(col, row), first)
		dancers[i].transform.origin = worldPos;
