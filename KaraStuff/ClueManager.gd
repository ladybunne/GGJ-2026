# Keeps track of clues learned.
class_name ClueManager extends Node3D

var target_mask: MaskData :
	get():
		return MaskManager.target_mask

@export var clues: Array[ClueData]
@export var target_name: String = ""

var last_preamble_string_index: int = -1
var last_clue_string_index: int = -1

func _ready() -> void:
	# Pick a random target name.
	target_name = Strings.TARGET_NAMES[RNG.rng.randi_range(0, Strings.TARGET_NAMES.size() - 1)]
	
	# Generate a random clue and print it.
	for i in range(1, 50):
		var clue = generate_new_clue()
		if clue != null:
			print("{i} {clue}".format({
				"i": i,
				"clue": format_clue_string(clue)}
			))
		else:
			print("{i} {noclue}".format({
				"i": i,
				"noclue": "No clue left to generate."
			}))
			print("Known mask: {colour} {pattern} {shape} mask with a {accessory}".format({
				"colour": MaskData.MASK_COLOUR_NAMES[MaskData.MASK_COLOURS.find(target_mask.colour)],
				"pattern": MaskData.MaskPattern.find_key(target_mask.pattern).to_lower(),
				"shape": MaskData.MaskShape.find_key(target_mask.shape).to_lower(),
				"accessory": MaskData.MaskAccessory.find_key(target_mask.accessory).to_lower()
			}))
			break

func generate_new_clue() -> ClueData:
	# Need to prevent useless clues.
	var categories = ["colour", "pattern", "shape", "accessory"]
	
	var available_categories = []
	var available_clues_per_category: Dictionary[String, Array] = {}
	
	# For each category...
	for category in categories:
		# Filter to only clues of that category.
		var relevant_clues = clues.filter(func (clue: ClueData): return clue.clue_category == category)
		# Compile a list of values that show up in clues of this category.
		var existing_values = relevant_clues.map(func (clue: ClueData): return clue.clue_value)
		
		# If there's less than the total size of the category, it's available.
		#if existing_values.size() < get_array_for_clue_category(category).size():
			#available_categories.append(category)
		
		# Invert the existing values to get the available values.
		var available_values = range(0, get_array_for_clue_category(category).size())
		for value in existing_values:
			available_values.remove_at(available_values.find(value))
		
		if available_values.size() > 0:
			available_categories.append(category)
			
		# Add them to the category availability dictionary.
		available_clues_per_category[category] = available_values
	
	if available_categories.size() <= 0:
		# No clues are available, so they should know the mask now.
		return null
	
	for testing_category in available_categories:
		assert(available_clues_per_category[testing_category].size() > 0)
	
	# Now, randomly pick an available category...
	var chosen_category = available_categories[RNG.rng.randi_range(0, available_categories.size() - 1)]
	
	# And pick a random value from that category.
	var chosen_value = available_clues_per_category[chosen_category][RNG.rng.randi_range(0, available_clues_per_category[chosen_category].size() - 1)]
	
	
	# Duplicate clue string prevention.
	var new_clue_string_index = RNG.rng.randi_range(0, Strings.CLUE_FORMATS.size() - 1)
	if new_clue_string_index == last_clue_string_index:
		new_clue_string_index = (new_clue_string_index + 1) % Strings.CLUE_FORMATS.size()
	
	var new_preamble_string_index = RNG.rng.randi_range(0, Strings.CLUE_PREAMBLES.size() - 1)
	if new_preamble_string_index == last_preamble_string_index:
		new_preamble_string_index = (new_preamble_string_index + 1) % Strings.CLUE_PREAMBLES.size()
	
	var new_clue_string = "{preamble} {actual_clue}".format({
		"preamble": Strings.CLUE_PREAMBLES[new_preamble_string_index],
		"actual_clue": Strings.CLUE_FORMATS[new_clue_string_index]
	})
	
	# Create the new clue.
	var new_clue = ClueData.new(new_clue_string, chosen_category, chosen_value)
	
	# Put the new clue in the clues array.
	clues.append(new_clue)
	last_clue_string_index = new_clue_string_index
	last_preamble_string_index = new_preamble_string_index
	
	# Finally...
	return new_clue

func format_clue_string(clue: ClueData):
	return clue.clue_text.format({
		"name": target_name,
		"category": Strings.CATEGORY_NOUNS[clue.clue_category],
		"value": ClueManager.get_string_value_for_clue(clue.clue_category, clue.clue_value)
		})

static func get_array_for_clue_category(p_clue_category: String) -> Array:
	match p_clue_category:
		"colour": 
			return MaskData.MASK_COLOURS
		"pattern":
			return MaskData.MaskPattern.values()
		"shape":
			return MaskData.MaskShape.values()
		"accessory":
			return MaskData.MaskAccessory.values()
		_:
			assert(false)
			return []
			
static func get_value_for_clue(p_category_array: Array, p_clue_value: int) -> String:
	return str(p_category_array[p_clue_value])
	
static func get_string_value_for_clue(p_clue_category: String, p_clue_value: int) -> String:
	match p_clue_category:
		"colour": 
			return MaskData.MASK_COLOUR_NAMES[p_clue_value].to_lower()
		"pattern":
			return MaskData.MaskPattern.find_key(p_clue_value).to_lower()
		"shape":
			return MaskData.MaskShape.find_key(p_clue_value).to_lower()
		"accessory":
			return MaskData.MaskAccessory.find_key(p_clue_value).to_lower()
		_:
			assert(false)
			return ""
