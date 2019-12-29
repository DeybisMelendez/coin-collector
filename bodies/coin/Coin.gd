extends Area2D
var touched = false
export (PackedScene) var Points
func _ready():
	connect("body_entered", self, "body_entered")
	$AnimationPlayer.connect("animation_finished", self, "animation_finished")

func animation_finished(_animation):
	queue_free()

func body_entered(body):
	if not touched:
		if body.is_in_group("ball"):
			touched = true
			if get_tree().current_scene.has_method("add_score"):
				get_tree().current_scene.add_score(100)
			Sounds.Coin()
			$AnimationPlayer.play("taken")
			var new_points = Points.instance()
			new_points.position = global_position
			new_points.get_node("Label").text = "100"
			get_parent().add_child(new_points)