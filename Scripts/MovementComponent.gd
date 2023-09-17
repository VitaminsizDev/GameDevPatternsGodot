extends Node2D

enum MovementMode { TRANSLATE, RIGIDBODY }

@export var is_enabled = true
@export var parent:RigidBody2D
@export var move_speed = 200
@export var rotation_speed = 100
@export var MovementType = MovementMode.TRANSLATE


func _ready():
	$"../InputComponent".connect("input_received", move)


func move(horizontal:float, vertical:float):
	if not is_enabled:
		return
	
	match MovementType:
		MovementMode.TRANSLATE:
			_move_translate_based(horizontal, vertical)
		MovementMode.RIGIDBODY:
			_move_rigidbody_based(horizontal, vertical)


func _move_translate_based(horizontal:float, vertical:float):
	parent.rotation_degrees += rotation_speed * get_physics_process_delta_time() * horizontal

	var direction = Vector2(0, -1).rotated(parent.rotation)
	parent.translate(direction * move_speed * get_physics_process_delta_time() * vertical)
	

func _move_rigidbody_based(horizontal:float, vertical:float):
	parent.apply_torque(rotation_speed * horizontal * 10)

	var direction = Vector2(0, -1).rotated(parent.rotation)
	parent.apply_force(direction * move_speed * vertical)
