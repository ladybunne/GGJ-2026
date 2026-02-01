extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_start_pressed() -> void:
	print("start_pressed")
	get_tree().change_scene_to_file("res://Main.tscn")

func _on_button_exit_pressed() -> void:
	print("Exit_pressed")
	get_tree().quit()

func _on_button_credits_pressed() -> void:
	print("Credits_pressed")
	get_tree().change_scene_to_file("res://Scene_Credits.tscn")
