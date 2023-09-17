extends Node2D
class_name Booster

enum BoostPosition {LEFT, RIGHT}

@export var boost_position = BoostPosition.LEFT

var _original_booster_scale
var _original_light_scale
var _boost_sprite_2d
var _point_light_2d


# Called when the node enters the scene tree for the first time.
func _ready():
	$"../InputComponent".connect("input_received", _boost)
	$"../InputComponent".connect("input_stopped", _disable_boost)

	# Save original transform scale
	_boost_sprite_2d = $BoostEffect as Sprite2D
	_original_booster_scale = _boost_sprite_2d.get_transform().get_scale()
	_boost_sprite_2d.scale = Vector2(0,0)

	# Save original light energy
	_point_light_2d = $PointLight2D as PointLight2D
	_original_light_scale = _point_light_2d.get_transform().get_scale()
	_point_light_2d.scale = Vector2(0,0)
	

func _boost(horizontal:float, vertical:float):
	if vertical > 0:
		_enable_boost()
	elif boost_position == BoostPosition.LEFT:
		if horizontal > 0:
			_enable_boost()
		else:
			_disable_boost()
	else:
		if horizontal < 0:
			_enable_boost()
		else:
			_disable_boost()


func _enable_boost():
	var _boost_tween = create_tween()
	_boost_tween.set_parallel(true)
	_boost_tween.set_ease(Tween.EASE_IN_OUT)
	_boost_tween.tween_property(_boost_sprite_2d, "scale:y",_original_booster_scale.y, .3)
	_boost_tween.tween_property(_boost_sprite_2d, "scale:x",_original_booster_scale.x, 1)

	var _light_tween = create_tween()
	_light_tween.set_ease(Tween.EASE_IN_OUT)
	_light_tween.tween_property(_point_light_2d, "scale",_original_light_scale, 1)


func _disable_boost():
	var _boost_tween_reverse = create_tween()
	_boost_tween_reverse.set_parallel(true)
	_boost_tween_reverse.set_ease(Tween.EASE_IN_OUT)
	_boost_tween_reverse.tween_property(_boost_sprite_2d, "scale:y",0, .3)
	_boost_tween_reverse.tween_property(_boost_sprite_2d, "scale:x",0, 1)

	var _light_tween_reverse = create_tween()
	_light_tween_reverse.set_ease(Tween.EASE_IN_OUT)
	_light_tween_reverse.tween_property(_point_light_2d, "scale",Vector2(0,0), 1)
