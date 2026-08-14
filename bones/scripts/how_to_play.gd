extends Node2D

func _ready() -> void:
	MusicController.get_node("Music").play()
