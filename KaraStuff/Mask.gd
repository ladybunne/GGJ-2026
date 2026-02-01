class_name Mask extends Node3D

var mask_prefab: MeshInstance3D

const MASK_PREFABS: Array[PackedScene] = [
	preload("res://Riley/Prefabs/Masks/P_mask_1.tscn"),
	preload("res://Riley/Prefabs/Masks/P_mask_2.tscn"),
	preload("res://Riley/Prefabs/Masks/P_mask_3.tscn"),
	preload("res://Riley/Prefabs/Masks/P_mask_4.tscn"),
	preload("res://Riley/Prefabs/Masks/P_mask_5.tscn"),
	preload("res://Riley/Prefabs/Masks/P_mask_6.tscn"),
	preload("res://Riley/Prefabs/Masks/P_mask_7.tscn")
]

var accessory_prefab: MeshInstance3D

const ACCESSORY_PREFABS: Array[PackedScene] = [
	preload("res://Riley/Prefabs/Accessories/P_accessories_feather.tscn"),
	preload("res://Riley/Prefabs/Accessories/P_accessories_flower.tscn"),
	preload("res://Riley/Prefabs/Accessories/P_accessories_gem.tscn"),
	preload("res://Riley/Prefabs/Accessories/P_accessories_teardrop.tscn")
]

static var pattern_materials: Array[StandardMaterial3D] = [
	StandardMaterial3D.new(),
	preload("res://Materials/Mat_Mask_Pattern_Stripes.tres"),
	preload("res://Materials/Mat_Mask_Pattern_Dots.tres"),
	preload("res://Materials/Mat_Mask_Pattern_Shatter.tres"),
]

@export var mask_data: MaskData : 
	set(p_mask_data):
		mask_data = p_mask_data
		update_appearance()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_appearance()

func update_appearance() -> void:
	if mask_data == null:
		return
	
	# Shape
	if mask_prefab != null:
		mask_prefab.free()
	mask_prefab = MASK_PREFABS[mask_data.shape].instantiate()
	add_child(mask_prefab)
	
	# Accessory
	if accessory_prefab != null:
		accessory_prefab.free()
	accessory_prefab = ACCESSORY_PREFABS[mask_data.accessory].instantiate()
	add_child(accessory_prefab)
	
	# Colour
	var mask_material = StandardMaterial3D.new()
	mask_material.albedo_color = mask_data.colour
	var mask_pattern_material = pattern_materials[mask_data.pattern].duplicate()
	mask_pattern_material.albedo_color = mask_data.colour

	var first = true
	for child in mask_prefab.get_children(true):
		if first:
			child.material_override = mask_pattern_material
			first = false
			continue
		child.material_override = mask_material
	
	var accessory_material = StandardMaterial3D.new()
	accessory_material.albedo_color = mask_data.colour.lightened(0.5)
	accessory_prefab.material_override = accessory_material
