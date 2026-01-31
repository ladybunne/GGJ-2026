class_name Dancer extends Node3D

@onready var dress_scene: Node3D = $PrefabDress
@onready var suit_scene: Node3D = $PrefabSuit
@onready var mask: Mask = $Mask

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
		dress_scene.visible = dress
		suit_scene.visible = !dress
