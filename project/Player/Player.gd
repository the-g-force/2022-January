extends KinematicBody

export var speed = 1


func _physics_process(_delta):
	var direction = Vector2(
		Input.get_axis("move_left", "move_right"),
		Input.get_axis("move_up", "move_down"))
	
	var thrust = direction.length() * speed
		
	if thrust != 0:
		rotation.y = -direction.angle()

	
	var _ignored := move_and_collide(Vector3(thrust,0,0).rotated(Vector3.UP, -direction.angle()))
