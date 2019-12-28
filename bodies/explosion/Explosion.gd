extends CPUParticles2D

func _ready():
	emitting = true
	$Timer.connect("timeout", self, "timeout")

func timeout():
	queue_free()