extends HBoxContainer

var player_max_health = PlayerGlobals.player_max_health
onready var hb_left_tex = preload("res://gui/healthstats/assets/healthbar_L.png")
onready var hb_right_tex = preload("res://gui/healthstats/assets/healthbar_R.png")
onready var hb_right_2_tex = preload("res://gui/healthstats/assets/healthbar_R_2.png")
onready var hb_1_tex = preload("res://gui/healthstats/assets/healthbar_1.png")
onready var hb_2_tex = preload("res://gui/healthstats/assets/healthbar_2.png")

var halt_health_gen = false

func _ready():
	SignalManager.connect("player_max_health_changed", self, "_on_Player_max_health_changed")

func _process(delta):
	player_max_health = PlayerGlobals.player_max_health
	if get_child_count() != PlayerGlobals.player_max_health && PlayerGlobals.player_max_health != null:
		for i in PlayerGlobals.player_max_health:
			if i == 0:
				var hb_left = TextureRect.new()
				hb_left.texture = hb_left_tex
				add_child(hb_left)
			elif i % 2 != 0 && i != player_max_health-1:
				var hb_bar = TextureRect.new()
				hb_bar.texture = hb_1_tex
				add_child(hb_bar)
			elif i % 2 == 0 && i != player_max_health-1:
				var hb_bar_2 = TextureRect.new()
				hb_bar_2.texture = hb_2_tex
				add_child(hb_bar_2)
			elif i == player_max_health-1 && player_max_health % 2 != 0:
				var hb_right = TextureRect.new()
				hb_right.texture = hb_right_tex
				add_child(hb_right)
			else:
				var hb_right_2 = TextureRect.new()
				hb_right_2.texture = hb_right_2_tex
				add_child(hb_right_2)

func _on_Player_max_health_changed(new_health):
	for child in get_children():
		remove_child(child)
	player_max_health = new_health
