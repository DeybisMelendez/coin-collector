extends Area2D
var touched = false
func _ready():
	connect("body_entered", self, "body_entered")

func body_entered(body):
	if not touched:
		if body.is_in_group("ball"):
			touched = true
			body.add_score()
			queue_free()