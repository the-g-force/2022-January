extends Control

var pressed : bool = false

func _input(event):	
	if not pressed and event is InputEventMouseButton:
		var e = event as InputEventMouseButton
		if e.is_pressed():
			# warning-ignore:return_value_discarded
			get_node("AnimationPlayer").play("splash screen")
			pressed = true



func _on_Button_pressed():
	# warning-ignore:return_value_discarded
 get_tree().change_scene("res://World/World.tscn")
