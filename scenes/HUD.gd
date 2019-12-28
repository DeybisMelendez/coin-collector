extends Control

#func _ready():
#	get_tree().paused = true
#
#func unpause():
#	get_tree().paused = false

func set_level(level):
	$HBoxContainer/Level.text = "Level " + str(level)

func set_score(score):
	$HBoxContainer/Score.text = "Score " + str(score)

func set_balls(balls):
	$HBoxContainer/Balls.text = "Balls " + str(balls)