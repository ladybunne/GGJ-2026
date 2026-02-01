class_name MaskData extends Resource

# KARA'S NOTES
#
# All of these arrays / enums can be changed freely, and all of the
# generation stuff will work accordingly. Just need to make sure that
# colours and names match.
#
# Enum names will get converted to lowercase, which should be fine.

const MASK_COLOURS: Array[Color] = [Color.RED, Color.CORNFLOWER_BLUE, Color.ORANGE, Color.PURPLE]
const MASK_COLOUR_NAMES: Array[String] = ["red", "blue", "gold", "purple"]

@export_color_no_alpha var colour: Color = Color.WHITE

enum MaskPattern { PLAIN, STRIPED, SPOTTED, SHATTERED }
@export var pattern: MaskPattern = MaskPattern.PLAIN

enum MaskShape { BUTTERFLY, WINGED, EARED, OVAL, HEART, SHIELD, HALF }
@export var shape: MaskShape = MaskShape.BUTTERFLY

enum MaskAccessory { FEATHER, FLOWER, GEM, TEARDROP }
@export var accessory: MaskAccessory = MaskAccessory.FEATHER

# Decided not to add attire (suit vs dress) as it's more fun for
# that to just be flavour, rather than 

func _init(p_colour: Color = colour, p_pattern: MaskPattern = pattern,
	p_shape: MaskShape = shape, p_accessory: MaskAccessory = accessory) -> void:
	colour = p_colour
	pattern = p_pattern
	shape = p_shape
	accessory = p_accessory
	
static func GetAllPermutations() -> Array[MaskData]:
	var permutations: Array[MaskData] = []
	
	for newcolour in MASK_COLOURS:
		for newpattern in MaskPattern.values():
			for newshape in MaskShape.values():
				for newaccessory in MaskAccessory.values():
					permutations.push_back(MaskData.new(newcolour, newpattern, newshape, newaccessory))
	
	return permutations

func debug_print():
	print("%s %s %s %s" % [colour, MaskPattern.find_key(pattern), MaskShape.find_key(shape), MaskAccessory.find_key(accessory)])
