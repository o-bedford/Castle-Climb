extends PlayerState

var was_smashing:bool = false
var was_sprinting:bool = false
var can_turn:bool = true

var dash_direction

func enter(msg := {}) -> void:
	was_smashing = false
	was_sprinting = false
	can_turn = true
	if msg.has("do_jump"):
		player.velocity.y = -player.jump_impulse 
		print("Jump")
	if msg.has("was_smashing"):
		was_smashing = true
		dash_direction = msg.get("_dash_direction")
	if msg.has("was_sprinting"):
		was_sprinting = true
		can_turn = false

func update(delta:float) -> void:
	if !was_smashing and can_turn:
		player.speed = lerp(player.speed, player.BASE_SPEED, 0.2)
		player.velocity.x = player.speed * player.get_input_direction_x()
	player.velocity.y += player.gravity * delta
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)
	
	if player.is_on_floor():
		if is_equal_approx(player.get_input_direction_x(), 0.0):
			state_machine.transition_to("Idle")
		elif was_sprinting and Input.is_action_pressed("sprint"):
			print("Sprint")
			state_machine.transition_to("Sprint")
		else:
			state_machine.transition_to("Walk")
	else:
		if was_smashing:
			if player.get_input_direction_x() != dash_direction && player.get_input_direction_x() != 0:
				print("woah")
				player.speed = player.BASE_SPEED
				state_machine.transition_to("Air")
