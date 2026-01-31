class_name DancePattern

enum DanceDirection {
	none,
	up,
	right,
	down,
	left,
}

static var DirectionOffsets = {
	DanceDirection.none : Vector2i(0, 0),
	DanceDirection.up : Vector2i(0, 1),
	DanceDirection.right : Vector2i(1, 0),
	DanceDirection.down : Vector2i(0, -1),
	DanceDirection.left : Vector2i(-1, 0),
}



var cols : int
var rows : int

var towardDirections : Array[DanceDirection]

func _init(_cols : int, _rows : int):
	cols = _cols
	rows = _rows
	towardDirections.resize(cols * rows)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func GetTowardDirectionAt(dancePos : Vector2i) -> int:
	var index = GridUtils.IndexOf1DFrom2D(cols, rows, dancePos)
	return towardDirections[index];

func SetAt(dancePos : Vector2i, direction : DanceDirection) -> void:
	var index = GridUtils.IndexOf1DFrom2D(cols, rows, dancePos)
	towardDirections[index] = direction;

# func Flip():
