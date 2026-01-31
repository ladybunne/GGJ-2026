extends Node

# Feel free to add more to this, just keep it consistent.
const TARGET_NAMES = [
	"Dame Blueberry",
	"Admiral Violet",
	"Princess Lime",
	"Prince Burgundy"
]

# We could do with a lot more of these. I did implement a feature
# where it'll forcibly pick a different clue if it randomly rolls
# the same string twice in a row.

# Need to rewrite clue format to negate, not confirm.
const CLUE_FORMATS = [
	"{name} looks so cool tonight! I love their mask's {value} {category}!",
	"Doesn't {name} have a breathtaking presence? In particular, I adore the {value} {category} of their mask.",
	"Oh, hello! Lovely to see you here! Have you come across {name} yet? They look so fetching! They really stand out with their mask's {value} {category}."
]

# Currently unused, but can be wired up if we end up getting informants implemented.
const INFORMANT_CLUE_FORMATS = [
	"Hello, Agent. I've uncovered intel suggesting that {name}'s mask has a {value} {category}.",
	"Ah, Agent, good to see you! It has been observed that the {category} of {name}'s mask is {value}.",
	"Agent. Commit the following to memory: {name}'s mask {category} is {value}."
]

# Mostly to force "colour" to show up as "pigment".
const CATEGORY_NOUNS = {
	"colour": "pigment",
	"pattern": "pattern",
	"shape": "shape",
	"accessory": "accessory"
}
