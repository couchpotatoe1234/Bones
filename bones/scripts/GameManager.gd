extends Node

var total_coins: int = 0
var current_level = "res://scenes/Game8.tscn"
var deaths = 0
var has_double_jump = false
var controls_allowed: bool = true

func add_coin() -> void:
	total_coins += 1
	print("coins:", total_coins)

signal player_lives_changed(new_lives)
