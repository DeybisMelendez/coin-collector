extends Area2D
var touched = false
func _ready():
	connect("body_entered", self, "body_entered")

func body_entered(body):
	if not touched:
		if body.is_in_group("ball"):
			touched = true
			if get_tree().current_scene.has_method("add_score"):
				get_tree().current_scene.add_score()
			queue_free()