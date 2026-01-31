extends Node

@export var gridCols : int;
@export var gridRows : int;

@export var widthBetweenPairs : float
@export var heightBetweenPairs : float

@export var dancerBetweenSpacing : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ArrangeIntoPositions()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Leaving here for debugging
	ArrangeIntoPositions()
	pass

func ArrangeIntoPositions() -> void:
	var dancers = get_children()
	var halfTotalWidth : float = widthBetweenPairs * (gridCols - 1) / 2.0
	var halfTotalHeight : float = heightBetweenPairs * (gridRows - 1) / 2.0
	for i : int in(dancers.size()):
		var col : int = (i / 2)  % gridCols
		var row : int = (i / 2) / gridCols
		var first : bool = i % 2 == 1;
		var x : float = widthBetweenPairs * col
		if (first):
			x += dancerBetweenSpacing / 2.0
		else:
			x -= dancerBetweenSpacing / 2.0
		var z : float = heightBetweenPairs * row
		x -= halfTotalWidth
		z -= halfTotalHeight
		dancers[i].transform.origin = Vector3(x, 0.0, z)
