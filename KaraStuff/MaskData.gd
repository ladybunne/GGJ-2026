class_name MaskData extends Resource

const MASK_COLOURS: Array[Color] = [Color.WHITE, Color.RED, Color.BLUE, Color.ORANGE]
@export_color_no_alpha var colour: Color = Color.WHITE

enum MaskPattern { PLAIN, STRIPES, SPOTS }
@export var pattern: MaskPattern = MaskPattern.PLAIN

enum MaskShape { HEAD, FACE, HALFFACE }
@export var shape: MaskShape = MaskShape.FACE

enum MaskVariant { VARIANT_1, VARIANT_2, VARIANT_3 }
@export var variant: MaskVariant = MaskVariant.VARIANT_1

# Decided not to add attire (suit vs dress) as it's more fun for
# that to just be flavour, rather than 

func _init(p_colour: Color = colour, p_pattern: MaskPattern = pattern,
	p_shape: MaskShape = shape, p_variant: MaskVariant = variant) -> void:
	colour = p_colour
	pattern = p_pattern
	shape = p_shape
	variant = p_variant
	
static func GetAllPermutations() -> Array[MaskData]:
	var permutations: Array[MaskData] = []
	
	for newcolour in MASK_COLOURS:
		for newpattern in MaskPattern.values():
			for newshape in MaskShape.values():
				for newvariant in MaskVariant.values():
					permutations.push_back(MaskData.new(newcolour, newpattern, newshape, newvariant))
	
	return permutations

func debug_print():
	print("%s %s %s %s" % [colour, MaskPattern.find_key(pattern), MaskShape.find_key(shape), MaskVariant.find_key(variant)])
