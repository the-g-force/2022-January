extends KinematicBody

export var direction : Vector3
export var speed := 100


func _physics_process(delta):
	var collision := move_and_collide(direction*speed*delta)
	
	if collision!=null and collision.collider.has_method('damage'):
		collision.collider.damage()
		queue_free()


func _on_VisibilityNotifier_screen_exited():
	queue_free()
