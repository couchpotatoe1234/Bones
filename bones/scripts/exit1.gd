extends Area2D

func _on_body_entered(body: Node2D) -> void:
	TransitionLayer.change_scene("res://scenes/Game3.tscn")
	GameManager.current_level = "res://scenes/Game3.tscn"
