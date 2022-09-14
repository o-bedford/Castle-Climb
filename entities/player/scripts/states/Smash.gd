extends PlayerState

var dash_direction

var stop:bool = false

func enter(_msg := {}) -> void:
#	print(player.attack_timer.time_left)
	stop = false
	player.attack_timer.start()
	print("Dash!")
	player.speed = player.SMASH_SPEED
	dash_direction = player.facing

func update(delta:float) -> void:
	print(str(player.speed))
	player.velocity.x = player.speed * dash_direction
	player.velocity.y += player.gravity * delta
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)
	
	if dash_direction != player.get_input_direction_x() && player.get_input_direction_x() != 0:
		player.speed = player.BASE_SPEED
		print("Walk")
		state_machine.transition_to("Walk")
	
	if stop && player.is_on_floor():
		player.speed = player.BASE_SPEED
		print("Walk")
		state_machine.transition_to("Walk")
	
	if Input.is_action_just_pressed("move_up"):
		state_machine.transition_to("Air", {do_jump = true, was_smashing = true, _dash_direction = dash_direction})

func _on_Smash_Timer_timeout():
	stop = true
