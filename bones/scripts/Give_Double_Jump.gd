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
		GameManager.has_double_jump = true
		GameManager.controls_allowed = false
		$AnimationPlayer.play("Main")
		await $AnimationPlayer.animation_finished
		GameManager.controls_allowed = true
		queue_free()
