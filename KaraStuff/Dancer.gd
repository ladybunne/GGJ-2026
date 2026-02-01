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

const SKIRT_PREFABS: Array[PackedScene] = [
	preload("res://Riley/Prefabs/Bottoms/P_skirt_1.tscn"),
	preload("res://Riley/Prefabs/Bottoms/P_skirt_2.tscn"),
	preload("res://Riley/Prefabs/Bottoms/P_skirt_3.tscn"),
]

const DRESS_TOP_PREFABS: Array[PackedScene] = [
	preload("res://Riley/Prefabs/Tops/P_top_1.tscn"),
	preload("res://Riley/Prefabs/Tops/P_top_2.tscn"),
	preload("res://Riley/Prefabs/Tops/P_top_3.tscn"),
]

const SHIRT_PREFABS: Array[PackedScene] = [
	preload("res://Riley/Prefabs/Tops/P_shirt_1.tscn"),
	preload("res://Riley/Prefabs/Tops/P_shirt_2.tscn")
]

const HAIR_COLOURS: Array[Color] = [
	Color("efefc6")
]

const HAT_COLOURS: Array[Color] = [
	Color("634e3b")
]

var hair_hat_mesh: MeshInstance3D
var attire_top_mesh: MeshInstance3D
var attire_bottom_mesh: MeshInstance3D

var attire_darken_factor = 0.4

@export var mask_data: MaskData :
	set(p_mask_data):
		mask_data = p_mask_data
		if mask_data != null:
			mask_data.debug_print()
			mask.mask_data = mask_data
			update_attire()

@export var dress: bool = true :
	set(p_dress):
		dress = p_dress
		update_attire()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dress = RNG.rng.randi_range(0, 1) == 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update_attire() -> void:
	if mask_data == null:
		return
	if dress_scene != null and suit_scene != null:
		if hair_hat_mesh != null:
			hair_hat_mesh.free()
		if dress:
			# Hide existing top and skirt
			$P_CH_Dress/top.visible = false
			$P_CH_Dress/skirt.visible = false
			# Hair
			hair_hat_mesh = HAIR_PREFABS[RNG.rng.randi_range(0, HAIR_PREFABS.size() - 1)].instantiate()
			add_child(hair_hat_mesh)
			# Dress top
			attire_top_mesh = DRESS_TOP_PREFABS[RNG.rng.randi_range(0, DRESS_TOP_PREFABS.size() - 1)].instantiate()
			add_child(attire_top_mesh)
			# Dress bottom
			attire_bottom_mesh = SKIRT_PREFABS[RNG.rng.randi_range(0, SKIRT_PREFABS.size() - 1)].instantiate()
			add_child(attire_bottom_mesh)
			# Colour
			var dress_material = StandardMaterial3D.new()
			dress_material.albedo_color = mask_data.colour.darkened(attire_darken_factor)
			attire_top_mesh.get_child(1).material_override = dress_material
			attire_bottom_mesh.material_override = dress_material
			# Hair colour
			var hair_material = StandardMaterial3D.new()
			hair_material.albedo_color = HAIR_COLOURS[RNG.rng.randi_range(0, HAIR_COLOURS.size() - 1)]
			hair_hat_mesh.material_override = hair_material
		else:
			# No need to hide existing top for suit
			# Hat
			hair_hat_mesh = HAT_PREFABS[RNG.rng.randi_range(0, HAT_PREFABS.size() - 1)].instantiate()
			add_child(hair_hat_mesh)
			# Shirt
			attire_top_mesh = SHIRT_PREFABS[RNG.rng.randi_range(0, SHIRT_PREFABS.size() - 1)].instantiate()
			add_child(attire_top_mesh)
			# Colour
			var shirt_material = StandardMaterial3D.new()
			shirt_material.albedo_color = mask_data.colour.darkened(attire_darken_factor)
			attire_top_mesh.get_child(1).material_override = shirt_material
			# Hat colour
			var hat_material = StandardMaterial3D.new()
			hat_material.albedo_color = HAT_COLOURS[RNG.rng.randi_range(0, HAT_COLOURS.size() - 1)]
			hair_hat_mesh.material_override = hat_material
		dress_scene.visible = dress
		suit_scene.visible = !dress
