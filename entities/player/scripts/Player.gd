extends KinematicBody2D
class_name Player

export(int) var max_health
onready var health = max_health setget _set_health

const BASE_SPEED = 500
const TOP_SPRINT_SPEED = 900
const SMASH_SPEED = 800
var speed = 300
var gravity = 800
var jump_impulse = 400
var acceleration = 60
var friction = 20
var sprint_acceleration = 10

var velocity := Vector2.ZERO
var facing = 1

onready var attack_timer = get_node("Smash Timer")

onready var sprite = get_node("Sprite")

func _ready():
	PlayerGlobals.player_max_health = max_health
	SignalManager.emit_signal("player_health_changed", health)

func get_input_direction_x() -> float:
	var direction = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	if direction != 0:
		facing = direction
	# Flip sprite here
	return direction

func _set_health(new_health):
	var prev_health = health
	health = clamp(new_health, 0, max_health)
	if health != prev_health:
		SignalManager.emit_signal("player_health_changed", health)
