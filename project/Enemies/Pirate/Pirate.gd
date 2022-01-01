extends KinematicBody

const _Laser = preload("res://Enemies/EnemyLaser.tscn")
const _Explosion = preload("res://Explosion/Explosion.tscn")

export(NodePath) var target
export var rotation_speed := 0.01
export var speed := 0.75


func _physics_process(_delta):
	var player : Spatial = get_node(target)
	var vector_toward_target = player.transform.origin - transform.origin
	var angle = atan2(vector_toward_target.z, vector_toward_target.x)
	
	var short = short_angle_dist(rotation.y, -angle)
	rotation.y += clamp(short, -rotation_speed, rotation_speed)
	
	var _ignored := move_and_collide(Vector3(speed,0,0).rotated(Vector3.UP, rotation.y))
	

func damage():
	var explosion := _Explosion.instance()
	get_parent().add_child(explosion)
	explosion.transform = transform
	
	var salvage = preload("res://World/Salvage.tscn").instance()
	salvage.transform.origin = transform.origin
	get_parent().add_child(salvage)
	
	queue_free()


# H/T https://godotengine.org/qa/41043/lerping-angle-while-going-trought-shortest-possible-distance
func short_angle_dist(from, to):
	var max_angle = PI * 2
	var difference = fmod(to - from, max_angle)
	return fmod(2 * difference, max_angle) - difference


func _on_ShotTimer_timeout():
	var laser : Spatial = _Laser.instance()
	get_parent().add_child(laser)
	laser.transform = transform
