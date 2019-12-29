extends RigidBody2D

const FORCE = 1000

var state = "waiting"

onready var spawn = global_position

func _physics_process(_delta):
	if state == "moving":
		var bodies = get_colliding_bodies()
		if bodies.size() > 0:
			Sounds.Hit()
			if bodies[0].is_in_group("brick"):
				bodies[0].get_parent().collided()

func set_state(new_state):
	state = new_state
	match state:
		"waiting":
			mode = MODE_STATIC
			$CPUParticles2D.emitting = false
		"moving":
			mode = MODE_RIGID
			$CPUParticles2D.emitting = true
		"stop":
			mode = MODE_STATIC
			$CPUParticles2D.emitting = false

func shoot(direction):
	set_state("moving")
	apply_impulse(Vector2.ZERO, direction * FORCE)

func _input(event):
	if event is InputEventMouseButton:
		if not event.is_pressed():
			if event.get_button_index() == BUTTON_LEFT:
				if state == "waiting":
					var mouse_pos = get_global_mouse_position()
					var direction = (mouse_pos - global_position).normalized()
					shoot(direction)

func reset():
	set_state("waiting")
	global_position = spawn