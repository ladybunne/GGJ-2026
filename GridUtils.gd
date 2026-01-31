class_name GridUtils


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

static func IndexOf1DFrom2D(cols : int, rows : int, pos : Vector2i):
	return (pos.x % cols) + (pos.y * rows);

static func IndexOf2DFrom1D(cols: int, index : int):
	return Vector2i(index % cols, index / cols)
