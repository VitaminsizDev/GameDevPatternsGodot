extends Node2D

signal input_received(horizontal: float, vertical: float)
signal input_stopped()

@export var is_enabled: bool = true

var _horizontal: float = 0
var _vertical: float = 0

var _previous_input: Vector2 = Vector2.ZERO

func _process(_delta):
	if not is_enabled:
		return

	_horizontal = Input.get_axis("ui_left", "ui_right")
	_vertical = Input.get_axis("ui_down", "ui_up")
	
	if _horizontal != 0 or _vertical != 0:
		emit_signal("input_received", _horizontal, _vertical)

	if _horizontal == 0 and _vertical == 0 and _previous_input != Vector2.ZERO:
		emit_signal("input_stopped")

	_previous_input = Vector2(_horizontal, _vertical)
