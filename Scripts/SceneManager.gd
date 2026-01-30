#Autoload
extends Node3D

var mainCam: Camera3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mainCam = get_tree().get_first_node_in_group("Camera") 
	if mainCam== null:
		mainCam = Camera3D.new()
		var sun: DirectionalLight3D = DirectionalLight3D.new()
		Callable(func():get_tree().root.add_child(mainCam)).call_deferred()
		Callable(func():get_tree().root.add_child(sun)).call_deferred()
		await get_tree().process_frame
		mainCam.global_position = Vector3(0,0,10)
		sun.look_at(Vector3(0,-1,-1))
