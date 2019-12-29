extends Sprite
const PATH = "res://bodies/bricks/"
const PNG = ".png"
export var type = "diamond"
export var level = 0
export (PackedScene) var Explosion
export (PackedScene) var Points
var color = ["grey", "yellow", "blue", "green", "red", "purple"]

func _ready():
	set_type()
	type += "_"
	set_color()

func collided():
	var score = 5 + (level*5)
	if level < 5:
		level -= 1
		var new_points = Points.instance()
		new_points.get_node("Label").text = str(score)
		new_points.position = $Body.get_child(0).global_position
		get_parent().add_child(new_points)
		get_tree().current_scene.add_score(score)
	if level < 0:
		var new_explosion = Explosion.instance()
		new_explosion.position = $Body.get_child(0).global_position
		get_parent().add_child(new_explosion)
		queue_free()
	else:
		$AnimationPlayer.play("hit")
		set_color()

func set_color():
	texture = load(PATH + type + color[level] + PNG)

func set_type():
	var collision = load(PATH + type + ".tscn")
	$Body.add_child(collision.instance())
