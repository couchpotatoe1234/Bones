extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		var ray = RayCast2D.new()
		add_child(ray)
		ray.global_position = body.global_position
		ray.target_position = Vector2(0, 500.0)
		ray.force_raycast_update()
		if ray.is_colliding():
			var floor_collision_point = ray.get_collision_point()
			var safe_spawn_y = floor_collision_point.y - 10.0
			body.respawn_position = Vector2(body.global_position.x, safe_spawn_y)
		else:
			body.respawn_position = body.global_position
			
		ray.queue_free()
