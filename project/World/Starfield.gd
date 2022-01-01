extends Spatial

export var distance = 50

const SPACING = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(0,100):
		for j in range(0,100):
			var star : Spatial = preload("res://World/Star.tscn").instance()
			add_child(star)
			star.transform.origin = Vector3(i * SPACING, -distance, j * SPACING)
