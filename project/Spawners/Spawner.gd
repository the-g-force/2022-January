extends Spatial

const _Pirate := preload("res://Enemies/Pirate/Pirate.tscn")

export (NodePath) var player

onready var _visiblity_notifier := $VisibilityNotifier

func _on_Timer_timeout()->void:
	if _visiblity_notifier.is_on_screen():
		return
	var pirate := _Pirate.instance()
	
	var position_offset := Vector3.RIGHT.rotated(Vector3.UP, randf()*TAU)*16
	pirate.transform.origin = get_global_transform().origin + position_offset
	pirate.rotation.y = randf()*TAU
	
	pirate.target = player
	get_parent().add_child(pirate)
