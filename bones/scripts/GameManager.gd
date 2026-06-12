extends Node

var total_coins: int = 0

func add_coin() -> void:
	total_coins += 1
	print("coins:", total_coins)
