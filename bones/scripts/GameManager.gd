extends Node

var total_coins: int = 100
var current_level = "res://scenes/Ending.tscn"
var deaths = 0
var lives_lost = 0
var has_double_jump = true 
var controls_allowed: bool = true

func add_coin() -> void:
	total_coins += 1

signal player_lives_changed(new_lives)
