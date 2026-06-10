extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		var ground_y = self.global_position.y
		var safe_y = ground_y - 20.0 
		body.respawn_position = Vector2(body.global_position.x, safe_y)
		print("Checkpoint set safely above ground! X: ", body.global_position.x, " Y: ", safe_y)
