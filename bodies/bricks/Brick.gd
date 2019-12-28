extends Sprite
const PATH = "res://bodies/bricks/"
const PNG = ".png"
export var type = "diamond"
export var level = 0
export (PackedScene) var Explosion
var color = ["grey", "yellow", "blue", "green", "red", "purple"]

func _ready():
	set_type()
	type += "_"
	set_color()

func collided():
	if level < 5:
		level -= 1
	if level < 0:
		var new_explosion = Explosion.instance()
		new_explosion.position = $Body.get_child(0).global_position
		get_parent().add_child(new_explosion)
		queue_free()
	else:
		$AnimationPlayer.play("hit")
		set_color()
	get_tree().current_scene.add_score(5 + level*5)

func set_color():
	texture = load(PATH + type + color[level] + PNG)

func set_type():
	var collision = load(PATH + type + ".tscn")
	$Body.add_child(collision.instance())
