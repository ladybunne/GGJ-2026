class_name DanceManager extends Node3D

#all DancePairs
var allDancePairs: Array[DancePair]

#Dictionary of grid positions, and the DancePair assigned to each
var dancerGridPositions: Dictionary[Vector2, DancePair]

func assignAdjacentPairs():
	for pair in allDancePairs:
		pass
		#assign pair.adjacentPairs based on Grid Position

func swapDancers():
	pass
	#get random dancer from each pair
	#find which grid position is next in the dance (either by default, or through player input)
	#move each dancer to the new pair in the sequence
	#update dancers array in DancePairs
