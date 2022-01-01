extends Spatial

export var base_depth := 50
export var depth_variance := 10
export var base_stars := 200
export var star_variance := 50
export var screen_size_x := 1000
export var screen_size_y := 1000

const STAR := preload("res://World/Star.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var total_stars := base_stars
	total_stars += randi()%star_variance
	for s in total_stars:
		var star:Spatial = STAR.instance()
		var depth := base_depth
		depth += (randi()%depth_variance*2)-depth_variance
		var star_x := randi()%screen_size_x
		var star_y := randi()%screen_size_y
		star.transform.origin = Vector3(star_x, -depth, star_y)
		add_child(star)
