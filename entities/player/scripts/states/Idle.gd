extends PlayerState

func enter(_msg:={}) -> void:
	player.modulate = Color(1,1,1)
	player.speed = player.BASE_SPEED
#	player.velocity = Vector2.ZERO

func update(delta:float) -> void:
	if !player.is_on_floor():
		print("Air")
		state_machine.transition_to("Air")
		return
	
	if Input.is_action_just_pressed("move_up"):
		print("Air!")
		state_machine.transition_to("Air", {do_jump = true})
	elif Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("move_right"):
		print("Walk!")
		state_machine.transition_to("Walk")
#	So that the player doesn't have weird movement after pressing both left and right
	elif Input.is_action_just_released("move_left") or Input.is_action_just_released("move_right"):
		print("Walk!")
		state_machine.transition_to("Walk")
	elif Input.is_action_just_pressed("smash"):
		state_machine.transition_to("Smash")
