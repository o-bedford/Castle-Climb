extends HBoxContainer

var player_health

onready var heart_tex = preload("res://gui/healthstats/assets/heart.png")

func _ready():
	SignalManager.connect("player_health_changed", self, "_on_Player_health_changed")

func _process(delta):
	player_health = PlayerGlobals.player_health
	if player_health != null && get_child_count() != player_health:
		for i in player_health:
			var heart = TextureRect.new()
			heart.texture = heart_tex
			heart.rect_scale = Vector2(3,3)
			add_child(heart)

func _on_Player_health_changed(new_health):
	for child in get_children():
		remove_child(child)
