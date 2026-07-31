extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		$Label.visible = true

func _on_body_exited(body: Node2D) -> void:
	if body.name == "player":
		$Label.visible = false
