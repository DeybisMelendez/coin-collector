extends Sprite
const PATH = "res://bodies/bricks/"
const PNG = ".png"
export var type = "diamond"
export var level = 0
var color = ["grey", "yellow", "blue", "green", "red", "purple"]

func _ready():
	set_type()
	type += "_"
	set_color()

func collided():
	level -= 1
	if level < 0:
		queue_free()
	else:
		set_color()

func set_color():
	texture = load(PATH + type + color[level] + PNG)

func set_type():
	var collision = load(PATH + type + ".tscn")
	$Body.add_child(collision.instance())
