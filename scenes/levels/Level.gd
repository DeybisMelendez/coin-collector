extends Node2D

export var ball_count = 10
export var level = 0
export var next_level_path = ""

onready var Ball = $Ball
onready var HUD = $HUD

var score = 0

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
	elif ball_count <= 0:
		HUD.you_lose_anim()
	else:
		ball_count -= 1
		HUD.set_balls(ball_count)
		Ball.reset()
#	if ball_count <= 0:
#		HUD.you_lose_anim()
#		#Ball.set_state("stop")
#	else:
#		var coins = get_tree().get_nodes_in_group("coin").size()
#		if coins <= 0:
#			next_level()
#			#Ball.set_state("stop")
#		else:
#			ball_count -= 1
#			HUD.set_balls(ball_count)
#			Ball.reset()

func add_score(points):
	score += points
	HUD.set_score(Global.score + score)

func next_level():
	Global.score += score
	$HUD.you_win_anim()
	yield($HUD.get_node("AnimationPlayer"),"animation_finished")
	get_tree().change_scene(next_level_path)