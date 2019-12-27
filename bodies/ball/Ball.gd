extends RigidBody2D

const FORCE = 400

var state = "waiting"

func _physics_process(delta):
	if state == "moving":
		var bodies = get_colliding_bodies()
		if bodies.size() > 0:
			if bodies[0].is_in_group("brick"):
				bodies[0].get_parent().collided()

func set_state(new_state):
	state = new_state
	match state:
		"waiting":
			mode = MODE_STATIC
		"moving":
			mode = MODE_RIGID

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