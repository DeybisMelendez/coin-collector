extends Sprite

onready var spawn = global_position.x

var speed = randi()%10 + 20

func _physics_process(delta):
	global_position.x += speed * delta
	if global_position.x >= 1200:
		global_position.x = spawn
		global_position.y = randi()%250