class_name DancePair extends Node3D

#re-set to new value after any given swap
var dancers: Array[Dancer]:
	set(value):
		if value.size() != 2:
			printerr("assigning wrong number of dancers to pair: ", value.size())
			dancers = dancers
		else:
			dancers = value

var randomDancer: Dancer:
	get:
		return dancers.pick_random()
