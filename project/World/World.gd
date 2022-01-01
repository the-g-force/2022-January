extends Spatial

func _physics_process(_delta):
	$Camera.transform.origin.x = $Player.transform.origin.x
	$Camera.transform.origin.z = $Player.transform.origin.z
	
