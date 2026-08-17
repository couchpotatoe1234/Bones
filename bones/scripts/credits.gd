extends Node2D

func _on_button_pressed() -> void:
	GameManager.lives_lost = 0
	GameManager.deaths = 0
	GameManager.total_coins = 0
	GameManager.current_scene = "res://scenes/how_to_play.tscn"
	TransitionLayer.change_scene("res://scenes/main_menu.tscn")
