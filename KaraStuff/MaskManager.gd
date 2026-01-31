# Manager to create permutations of masks.
class_name MaskManager extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	initialise_dancers()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Initialises all dancers to the initial game state.
func initialise_dancers() -> void:
	# Get a list of dancers.
	
	# Get a list of possible permutations.
	var permutations = MaskData.GetAllPermutations()
	
	print("%s permutations generated." % permutations.size())
	print("Printing all permutations.")
	for permutation in permutations:
		permutation.debug_print()
