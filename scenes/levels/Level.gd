extends Node2D

export var ball_count = 10
export var level = 0
export var next_level_path = ""

onready var Ball = $Ball
onready var HUD = $HUD

func _ready():
	HUD.set_balls(ball_count)
	HUD.set_score(Global.score)
	HUD.set_level(level)
	Ball.get_node("VisibilityNotifier2D").connect("screen_exited", self, "ball_exited")

func ball_exited():
	Sounds.BallOut()
	var coins = get_tree().get_nodes_in_group("coin").size()
	if coins <= 0:
		next_level()
		Ball.set_state("stop")
	else:
		ball_count -= 1
		HUD.set_balls(ball_count)
		Ball.reset()

func add_score(points):
	Global.score += points
	HUD.set_score(Global.score)

func next_level():
	$HUD.get_node("AnimationPlayer").play("youwin")
	yield($HUD.get_node("AnimationPlayer"),"animation_finished")
	get_tree().change_scene(next_level_path)