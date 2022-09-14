extends PlayerState

func enter(_msg := {}) -> void:
#	player.speed = player.BASE_SPEED
	player.modulate = Color(1,1,1)

func update(delta:float) -> void:
#	print(str(player.speed))
#	Keeps the player at BASE_SPEED while walking
	player.speed = lerp(player.speed, player.BASE_SPEED, 0.2)
	if !player.is_on_floor():
		state_machine.transition_to("Air")
		return
	
	player.velocity.x = player.speed * player.get_input_direction_x()
	player.velocity.y += player.gravity * delta
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)
	
	if Input.is_action_just_pressed("move_up"):
		print("Air!")
		state_machine.transition_to("Air", {do_jump = true})
	elif is_equal_approx(player.get_input_direction_x(), 0.0):
		print("Idle!")
		state_machine.transition_to("Idle")
	elif Input.is_action_just_pressed("smash"):
		state_machine.transition_to("Smash")
	elif Input.is_action_just_pressed("sprint"):
		state_machine.transition_to("Sprint")
