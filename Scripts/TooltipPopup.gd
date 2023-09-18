extends AnimatedPanel

@export var popup_button: AnimatedButton

func _ready():
	popup_button.connect("pressed", _toggle_popup)


func _toggle_popup():
	if self.visible:
		hide_with_animation()
		popup_button.toggle(false)
	else:
		show_with_animation()
		popup_button.toggle(true)
