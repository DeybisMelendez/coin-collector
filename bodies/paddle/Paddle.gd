extends StaticBody2D

var end = 920
var begin = 0
var duration = 3

func _ready():
	$Tween.connect("tween_all_completed", self, "tween_completed")
	tween_completed()

func tween_completed():
	var target = global_position
	if global_position.x == 0:
		target.x = end
	else:
		target.x = begin
	move_to(target)

func move_to(target):
	$Tween.interpolate_property(
			self,
			"global_position",
			global_position,
			target,
			duration,
			Tween.TRANS_LINEAR,
			Tween.EASE_IN_OUT,
			0)
	$Tween.start()