extends Node2D


func _ready() -> void:
	await $AnimationPlayer.animation_finished
	TransitionLayer.change_scene("res://scenes/Game2.tscn")
	GameManager.current_level = "res://scenes/Game2.tscn"
