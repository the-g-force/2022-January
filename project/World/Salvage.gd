extends StaticBody

export var rotation_speed = 4.0

func _physics_process(delta):
	rotate(Vector3.UP, rotation_speed*delta)
