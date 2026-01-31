extends Node

var rng = RandomNumberGenerator.new()

func _init() -> void:
	rng.seed = hash("rabbits")
