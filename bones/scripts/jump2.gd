extends AnimatedSprite2D

func _ready() -> void:
	play("default")
	animation_finished.connect(queue_free)

func _process(delta: float) -> void:
	var player = get_parent()
	if player.velocity.y >= 0:
		queue_free()
