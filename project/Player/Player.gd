extends KinematicBody

signal update_armor(armor)
signal update_salvage(salvage)
signal update_points(additional_points)
signal set_game_time(game_length)
signal game_over

const _Explosion = preload("res://Explosion/Explosion.tscn")
const _ImpactExplosion = preload("res://Explosion/ImpactExplosion.tscn")

export var speed = 1
export var rotation_speed = 0.15
export var armor := 3

var _Laserblast = preload("res://Player/Laserblast.tscn")
var _can_shoot := true
var _salvage := 0
var _freeze := false

onready var _shot_timer := $ShotTimer
onready var _armaments := $Armaments
onready var _game_timer := $GameTimer
onready var _second_timer := $SecondTimer

func _ready()->void:
	emit_signal("update_armor", armor)
	emit_signal("set_game_time", _game_timer.wait_time)


func _physics_process(_delta):
	
	if _freeze:
		return
	
	var direction = Vector2(
		Input.get_axis("move_left", "move_right"),
		Input.get_axis("move_up", "move_down")
	).normalized()
	
	var thrust = direction.length() * speed
		
	if thrust != 0:
		var current_direction = rotation.y
		var target_direction = -direction.angle()
		rotation.y += short_angle_dist(current_direction, target_direction) * rotation_speed
	
	var collision := move_and_collide(Vector3(thrust,0,0).rotated(Vector3.UP, rotation.y))
	if collision != null:
		if collision.collider is Salvage:
			collision.collider.queue_free()
			_salvage += 1
			emit_signal("update_salvage", _salvage)

	if Input.is_action_just_pressed("fire") and _can_shoot:
		for muzzle in _armaments.get_children():
			var blast = _Laserblast.instance()
			get_parent().add_child(blast)
			blast.transform.origin = muzzle.get_global_transform().origin
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


func damage():
	
	if _freeze:
		return
	
	armor -= 1
	
	if armor > 0:
		var impact := _ImpactExplosion.instance()
		add_child(impact)
	
	else:
		var explosion := _Explosion.instance()
		get_parent().add_child(explosion)
		explosion.transform = transform
	
		_freeze = true
		hide()
		_second_timer.stop()
		_game_timer.stop()
		
		emit_signal("game_over")
	
	emit_signal("update_armor", armor)


func drop_off()->void:
	var points := _salvage*_salvage
	emit_signal("update_points", points)
	
	_salvage = 0
	emit_signal("update_salvage", _salvage)


func _on_GameTimer_timeout()->void:
	emit_signal("game_over")
	_second_timer.stop()
	_freeze = true
