extends Control

class_name AnimatedPanel

var _original_scale: Vector2

# Override hide method to hide the control and its children
func hide_with_animation():
	_original_scale = self.scale

	# Scale the control to 0
	var scale_down_tween = create_tween()
	scale_down_tween.tween_property(self, "scale", Vector2(0,0), .3)

	# Hide the control when the tween is finished
	scale_down_tween.tween_callback(hide)


func show_with_animation():
	# Show the control
	show()

	# Scale the control to 1
	var scale_up_tween = create_tween()
	scale_up_tween.tween_property(self, "scale", _original_scale, .5).set_trans(Tween.TRANS_BACK)
