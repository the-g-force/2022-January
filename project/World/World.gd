extends Spatial

export var camera_vertical_offset := 30

func _physics_process(_delta):
	$Camera.transform.origin.x = $Player.transform.origin.x
	$Camera.transform.origin.z = $Player.transform.origin.z + camera_vertical_offset
	


func _on_Planet_body_entered(body:PhysicsBody)->void:
	if body.has_method("drop_off"):
		body.drop_off()
