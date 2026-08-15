extends Area2D

var body_in: bool = false
var saved_body: Node2D = null

func _on_body_entered(body: Node2D) -> void:
	body_in = true
	saved_body = body


func _on_body_exited(body: Node2D) -> void:
	body_in = false
	saved_body = null

func _process(delta: float) -> void:
	if body_in && Input.is_action_just_pressed("interact"):
		saved_body.hide()
		GameManager.current_level = "res://scenes/Game6.tscn"
		GameManager.controls_allowed = false
		TransitionLayer.change_scene(GameManager.current_level)
		await TransitionLayer.change_scene(GameManager.current_level)
		GameManager.controls_allowed = true
