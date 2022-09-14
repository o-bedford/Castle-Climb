extends Node

var player_max_health
var player_health

func _ready():
	SignalManager.connect("player_max_health_changed", self, "_on_Player_max_health_changed")
	SignalManager.connect("player_health_changed", self, "_on_Player_health_changed")

func _on_Player_max_health_changed(new_max_health):
	player_max_health = new_max_health

func _on_Player_health_changed(new_health):
	player_health = new_health
