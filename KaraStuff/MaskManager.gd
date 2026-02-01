# Manager to create permutations of masks.
class_name MaskManager extends Node3D

static var target_mask: MaskData

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	initialise_dancers()

# Initialises all dancers to the initial game state.
func initialise_dancers() -> void:
	# Get a list of dancers.
	var dancers: Array[Dancer]
	dancers.assign(get_tree().get_nodes_in_group("Dancers")) 
	
	# Get a list of possible permutations.
	var permutations: Array[MaskData] = MaskData.GetAllPermutations()
	
	# If not enough permutations, throw an error.
	assert(permutations.size() >= dancers.size())
	
	# For each dancer, get a random permutation.
	permutations.shuffle()
	
	target_mask = permutations[RNG.rng.randi_range(0, dancers.size())]
	target_mask = permutations[0]
	
	for i in range(0, dancers.size()):
		dancers[i].mask_data = permutations[i]
	
	#print("%s permutations generated." % permutations.size())
	#print("Printing all permutations.")
	#for permutation in permutations:
		#permutation.debug_print()
