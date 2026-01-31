# Keeps track of clues learned.
class_name ClueManager extends Node3D

@export var clues: Array[ClueData]
@export var target_name: String = ""

var last_clue_format: int = -1

func _init() -> void:
	# Pick a random target name.
	target_name = Strings.TARGET_NAMES[RNG.rng.randi_range(0, Strings.TARGET_NAMES.size() - 1)]
	
	# Generate a random clue and print it.
	var clue = ClueData.new(Strings.CLUE_FORMATS[RNG.rng.randi_range(0, Strings.CLUE_FORMATS.size() - 1)], "colour", 1)
	print(format_clue_string(clue))

func format_clue_string(clue: ClueData):
	return clue.clue_text.format({
		"name": target_name,
		"category": Strings.CATEGORY_NOUNS[clue.clue_category],
		"value": ClueManager.get_value_for_clue(ClueManager.get_array_for_clue_category(clue.clue_category), clue.clue_value)
		})

static func get_array_for_clue_category(p_clue_category: String) -> Array:
	match p_clue_category:
		"colour": 
			return MaskData.MASK_COLOUR_NAMES
		"pattern":
			return MaskData.MaskPattern.values()
		"shape":
			return MaskData.MaskShape.values()
		"accessory":
			return MaskData.MaskAccessory.values()
		_:
			assert(false)
			return []
			
static func get_value_for_clue(p_clue_category: Array, p_clue_value: int) -> String:
	return str(p_clue_category[p_clue_value])



# Generate random target name.
# Test clue.
