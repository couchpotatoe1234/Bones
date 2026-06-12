extends Label

func _process(_delta: float) -> void:
	text = ": %d" % GameManager.total_coins
