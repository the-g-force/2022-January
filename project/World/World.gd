extends Spatial

func _physics_process(delta):
	$Camera.transform.origin.x = $Player.transform.origin.x
	$Camera.transform.origin.z = $Player.transform.origin.z
	
