extends AnimationPlayer

func drain_coins() -> void:
	var duration: float = GameManager.total_coins * 0.05 
	var tween = create_tween()
	tween.tween_property(GameManager, "total_coins", 0, duration)
