extends KinematicBody

export var speed = 1
export var rotation_speed = 0.15

var _Laserblast = preload("res://Player/Laserblast.tscn")
var _can_shoot := true

onready var _shot_timer := $ShotTimer

func _physics_process(_delta):
	var direction = Vector2(
		Input.get_axis("move_left", "move_right"),
		Input.get_axis("move_up", "move_down")
	).normalized()
	
	var thrust = direction.length() * speed
		
	if thrust != 0:
		var current_direction = rotation.y
		var target_direction = -direction.angle()
		rotation.y += short_angle_dist(current_direction, target_direction) * rotation_speed
	
	var _ignored := move_and_collide(Vector3(thrust,0,0).rotated(Vector3.UP, rotation.y))

	if Input.is_action_just_pressed("fire") and _can_shoot:
		var blast = _Laserblast.instance()
		get_parent().add_child(blast)
		blast.transform.origin = transform.origin
		blast.direction = Vector3(1,0,0).rotated(Vector3.UP, rotation.y)
		
		_can_shoot = false
		_shot_timer.start()
		

func _on_ShotTimer_timeout():
	_can_shoot = true


# H/T https://godotengine.org/qa/41043/lerping-angle-while-going-trought-shortest-possible-distance
func short_angle_dist(from, to):
	var max_angle = PI * 2
	var difference = fmod(to - from, max_angle)
	return fmod(2 * difference, max_angle) - difference
