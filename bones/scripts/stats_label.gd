extends Label

func _ready() -> void:
	text = "You died: %d times\nYou lost: %d lives" % [
		GameManager.deaths,
		GameManager.lives_lost
	]
