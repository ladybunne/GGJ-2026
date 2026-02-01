class_name Dancer extends Node3D

@onready var dress_scene: Node3D = $P_CH_Dress
@onready var suit_scene: Node3D = $P_CH_Suit
@onready var mask: Mask = $Mask

const HAIR_PREFABS: Array[PackedScene] = [
	preload("res://Riley/Prefabs/Hairs & Hats/P_hairstyle_1.tscn"),
	preload("res://Riley/Prefabs/Hairs & Hats/P_hairstyle_2.tscn"),
	preload("res://Riley/Prefabs/Hairs & Hats/P_hairstyle_3.tscn"),
	preload("res://Riley/Prefabs/Hairs & Hats/P_hairstyle_4.tscn"),
]

const HAT_PREFABS: Array[PackedScene] = [
	preload("res://Riley/Prefabs/Hairs & Hats/P_hat_1.tscn"),
	preload("res://Riley/Prefabs/Hairs & Hats/P_hat_2.tscn"),
	preload("res://Riley/Prefabs/Hairs & Hats/P_hat_3.tscn"),
]

const HAIR_COLOURS: Array[Color] = [
	Color("efefc6")
]

const HAT_COLOURS: Array[Color] = [
	Color("634e3b")
]

var hair_hat_mesh: MeshInstance3D

var attire_darken_factor = 0.4

@export var mask_data: MaskData :
	set(p_mask_data):
		mask_data = p_mask_data
		if mask_data != null:
			mask_data.debug_print()

@export var dress: bool = true :
	set(p_dress):
		dress = p_dress
		update_attire()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mask.mask_data = mask_data
	update_attire()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update_attire() -> void:
	if dress_scene != null and suit_scene != null:
		if hair_hat_mesh != null:
			hair_hat_mesh.free()
		if dress:
			# Hair
			hair_hat_mesh = HAIR_PREFABS[RNG.rng.randi_range(0, HAIR_PREFABS.size() - 1)].instantiate()
			add_child(hair_hat_mesh)
			# Colour
			var skirt = $P_CH_Dress/skirt as MeshInstance3D
			var skirt_material = skirt.material_override as StandardMaterial3D
			skirt_material.albedo_color = mask_data.colour.darkened(attire_darken_factor)
			var top = $P_CH_Dress/top as MeshInstance3D
			var top_material = top.material_override as StandardMaterial3D
			top_material.albedo_color = mask_data.colour.darkened(attire_darken_factor)
			# Hair colour
			var hair_material = StandardMaterial3D.new()
			hair_material.albedo_color = HAIR_COLOURS[RNG.rng.randi_range(0, HAIR_COLOURS.size() - 1)]
			hair_hat_mesh.material_override = hair_material
		else:
			# Hat
			hair_hat_mesh = HAT_PREFABS[RNG.rng.randi_range(0, HAT_PREFABS.size() - 1)].instantiate()
			add_child(hair_hat_mesh)
			# Colour
			var top = $P_CH_Suit/top as MeshInstance3D
			var top_material = top.material_override as StandardMaterial3D
			top_material.albedo_color = mask_data.colour.darkened(attire_darken_factor)
			# Hat colour
			var hat_material = StandardMaterial3D.new()
			hat_material.albedo_color = HAT_COLOURS[RNG.rng.randi_range(0, HAT_COLOURS.size() - 1)]
			hair_hat_mesh.material_override = hat_material
		dress_scene.visible = dress
		suit_scene.visible = !dress
