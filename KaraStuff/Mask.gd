class_name Mask extends Node3D

@onready var mesh: MeshInstance3D = $MeshInstance3D

@export var mask_data: MaskData : 
	set(p_mask_data):
		mask_data = p_mask_data
		update_appearance()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_appearance()

func update_appearance() -> void:
	if mesh == null || mask_data == null:
		return
	mesh.mesh = BoxMesh.new()
