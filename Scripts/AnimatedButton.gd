extends Button

class_name AnimatedButton

@export var toggled_on: TextureRect
@export var toggled_off: TextureRect

var _original_scale: Vector2

func _ready():
	# On mouse entered call the function _highlighted
	connect("mouse_entered", _highlighted)

	_original_scale = self.scale

func _highlighted():
	var _highlight_tween = create_tween()
	_highlight_tween.tween_property(self,"scale",_original_scale + Vector2(.1,.1),.05)
	_highlight_tween.tween_property(self,"scale",_original_scale,.05)


func _pressed():
	var _pressed_tween = create_tween()
	_pressed_tween.tween_property(self,"scale",_original_scale * .2,.05)
	_pressed_tween.tween_property(self,"scale",_original_scale,.05)


func toggle(is_toggled: bool):
	if is_toggled:
		toggled_on.show()
		toggled_off.hide()
	else:
		toggled_on.hide()
		toggled_off.show()
