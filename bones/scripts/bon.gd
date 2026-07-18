extends Area2D

func _on_body_entered(body: CharacterBody2D) -> void:
	GameManager.add_coin()
	queue_free()
