class_name Dancer extends Node3D

@export var swapTimeSeconds: float = 0.5
@onready var targetPositionNode: Node3D = %TargetPosition
var targetPosition: Vector3:
	get:
		return targetPositionNode.global_position
var spinOrder: Array[Vector3] = [Vector3.FORWARD, Vector3.LEFT, Vector3.BACK,Vector3.RIGHT]
var spinIndex: int = 0
var spinCircleRotation: Vector3 = Vector3(0,360,0)
var isSpinning: bool = false
func moveToPosition(p_targetPos: Vector3)->void:
	isSpinning = true
	var moveTween: Tween = create_tween()
	moveTween.set_parallel(true)
	moveTween.tween_property(self, "global_position", p_targetPos, swapTimeSeconds)
	moveTween.tween_property(self, "rotation_degrees", rotation_degrees+spinCircleRotation, swapTimeSeconds)
	await moveTween.finished
	
	targetPositionNode.position = spinOrder[spinIndex]*4
	spinIndex+=1
	if spinIndex>= spinOrder.size():
		spinIndex=0
	#rotation_degrees = Vector3.ZERO
	isSpinning = false
	
	
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("debugAction"):
		if isSpinning:
			return
		print("moving!")
		moveToPosition(targetPosition)
		targetPositionNode.global_position=-targetPositionNode.global_position
