extends Node

var total_coins: int = 0
var current_level = "res://scenes/Game10.tscn"
var deaths = 0
var lives_lost = 0
var has_double_jump = true 
var controls_allowed: bool = true

func add_coin() -> void:
	MusicController.get_node("Coin").play()
	total_coins += 1

signal player_lives_changed(new_lives)
