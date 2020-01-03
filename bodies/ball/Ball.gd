extends RigidBody2D

const FORCE = 500

var state = "waiting"

onready var spawn = global_position

func _physics_process(_delta):
	if state == "moving":
		var bodies = get_colliding_bodies()
		if bodies.size() > 0:
			Sounds.Hit()
			var velocity = get_linear_velocity().normalized()
			set_linear_velocity(velocity*FORCE)
			if bodies[0].is_in_group("brick"):
				bodies[0].get_parent().collided()
			elif bodies[0].is_in_group("paddle"):
				reset()

func set_state(new_state):
	state = new_state
	match state:
		"waiting":
			set_mode(MODE_STATIC)
			$CPUParticles2D.emitting = false
		"moving":
			set_mode(MODE_RIGID)
			$CPUParticles2D.emitting = true
			$CollisionShape2D.set_disabled(false)
			$CollisionShape2D.show()
		"stop":
			set_mode(MODE_KINEMATIC)
			#$CPUParticles2D.emitting = false
			$CollisionShape2D.set_disabled(true)
			$CollisionShape2D.hide()

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
	set_state("stop")
	$Tween.interpolate_property(
			self,
			"global_position",
			global_position,
			spawn,
			1,
			Tween.TRANS_QUINT,
			Tween.EASE_OUT,
			0)
	$Tween.start()
	yield($Tween,"tween_all_completed")
	set_state("waiting")
	#global_position = spawn