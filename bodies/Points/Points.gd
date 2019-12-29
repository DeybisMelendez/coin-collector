extends Label

func _ready():
	$AnimationPlayer.connect("animation_finished", self, "animation_finished")

func animation_finished(animation):
	queue_free()