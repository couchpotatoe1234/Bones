extends Node2D


func _ready() -> void:
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file("res://scenes/Game2.tscn")
	GameManager.current_level = "res://scenes/Game2.tscn"
