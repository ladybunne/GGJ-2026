# Data for clues.
class_name ClueData extends Resource

# The text you get given for a clue, so they can be represented on the UI.
@export var clue_text: String = ""

# The property of the mask the clue pertains to.
@export var clue_category: String = ""

# The value of the property. (Assume all clues are negation for now.)
@export var clue_value: int = 0

func _init(p_clue_text: String = clue_text, p_clue_category: String = clue_category,
	p_clue_value: int = clue_value):
	clue_text = p_clue_text
	clue_category = p_clue_category
	clue_value = p_clue_value

func debug_print():
	print("{category} = {value}, '{text}'".format({
		"category": Strings.CATEGORY_NOUNS[clue_category],
		"value": ClueManager.get_value_for_clue(ClueManager.get_array_for_clue_category(clue_category), clue_value),
		"text": clue_text}))
