extends KinematicBody

export var speed := 100


func _physics_process(delta):
	var collision := move_and_collide(Vector3(speed*delta,0,0).rotated(Vector3.UP, rotation.y))
	
	# The only thing this can collide with is the player
	if collision!=null:
		assert(collision.collider.has_method('damage'))
		collision.collider.damage()
		queue_free()


func _on_VisibilityNotifier_screen_exited():
	queue_free()
