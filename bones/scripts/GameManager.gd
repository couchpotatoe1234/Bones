extends Node

var total_coins: int = 0
var current_level = "res://scenes/Game7.tscn"
var deaths = 0

func add_coin() -> void:
	total_coins += 1
	print("coins:", total_coins)

signal player_lives_changed(new_lives)
