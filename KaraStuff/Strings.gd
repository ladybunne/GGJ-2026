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

# Could possibly rewrite the clue format such that it has a preamble and a clue.

const CLUE_PREAMBLES = [
	"{name} looks so cool tonight!",
	"Doesn't {name} have a breathtaking presence?",
	"Oh, hello! Lovely to see you here! Have you come across {name} yet? They look so fetching!",
	"Such a marvelous party! Truly, {name} is the star of the show!",
	"I can't take my eyes off {name}! How ravishing!"
]

# Need to rewrite clue format to negate, not confirm.
const CLUE_FORMATS = [
	"Their mask didn't have a {value} {category} - a bold choice.",
	"I was surprised that their mask's {category} wasn't {value}!",
	"I don't remember exactly what their mask looked like, but I remember distinctly it didn't have a {value} {category}.",
	"Their mask? All I know is that its {category} wasn't {value}.",
	"That mask of theirs looked expensive. Can't remember exactly, but I think its {category} wasn't {value}.",
]

# Not used yet. If we have time.
const AFFIRMATIVE_CLUE_FORMATS = [
	"I love their mask's {value} {category}!",
	"In particular, I adore the {value} {category} of their mask.",
	"They really stand out with their mask's {value} {category}."
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
