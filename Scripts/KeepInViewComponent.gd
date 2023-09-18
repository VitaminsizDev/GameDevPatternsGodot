extends Node

@export var is_enabled = true
@export var parent: Node

var _camera: Camera2D

var _horizontal_start_end: Vector2 = Vector2(0, 0)
var _vertical_start_end: Vector2 = Vector2(0, 0)


func _ready():
	if parent == null:
		print("KeepInViewComponent: Parent not set. Disabling.")
		is_enabled = false
		return

	_camera = parent.get_viewport().get_camera_2d()

	_horizontal_start_end = Vector2(_camera.position.x - parent.get_viewport_rect().size.x/2, _camera.position.x + parent.get_viewport_rect().size.x/2)
	_vertical_start_end = Vector2(_camera.position.y - parent.get_viewport_rect().size.y/2, _camera.position.y + parent.get_viewport_rect().size.y/2)

	set_process(is_enabled)
	set_physics_process(is_enabled)


func _process(_delta):
	if not is_enabled:
		return

	call_deferred("_keep_in_camera_view")


func _keep_in_camera_view():
	if parent.position.x > _horizontal_start_end.y:
		parent.position.x = _horizontal_start_end.x
	elif parent.position.x < _horizontal_start_end.x:
		parent.position.x = _horizontal_start_end.y

	if parent.position.y > _vertical_start_end.y:
		parent.position.y = _vertical_start_end.x
	elif parent.position.y < _vertical_start_end.x:
		parent.position.y = _vertical_start_end.y
