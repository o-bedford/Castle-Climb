extends PlayerState

func enter(_msg := {}) -> void:
#	SignalManager.emit_signal("player_max_health_changed", PlayerGlobals.player_max_health-1)
	pass

func update(delta:float) -> void:
#	Acceleration up to TOP_SPRINT_SPEED
	if player.facing == 1:
		player.velocity.x = min(player.velocity.x + player.sprint_acceleration, player.TOP_SPRINT_SPEED)
		player.speed = player.velocity.x
	elif player.facing == -1:
		player.velocity.x = max(player.velocity.x - player.sprint_acceleration, -player.TOP_SPRINT_SPEED)
		player.speed = player.velocity.x
	
#	print(str(player.velocity.x))
	player.velocity.y += player.gravity * delta
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)
	if Input.is_action_just_pressed("move_up"):
		state_machine.transition_to("Air", {do_jump = true, was_sprinting = true})
	if Input.is_action_just_released("sprint"):
		state_machine.transition_to("Walk")
