extends KinematicBody

export var direction : Vector3
export var speed := 100


func _physics_process(delta):
	var _ignored := move_and_collide(direction*speed*delta)


func _on_VisibilityNotifier_screen_exited():
	queue_free()
