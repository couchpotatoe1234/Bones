extends CanvasLayer

@export var full_heart_tex : Texture2D
@export var broken_heart_tex : Texture2D
@export var empty_heart_tex : Texture2D

@onready var hearts_container = $HeartsContainer

func _ready() -> void:
	GameManager.player_lives_changed.connect(_on_lives_changed)
	if has_node("CoinCounter"):
		get_node("CoinCounter").text = str(GameManager.total_coins)

func _on_lives_changed(new_lives: int) -> void:
	var hearts = hearts_container.get_children()

	if new_lives >= 0 and new_lives < hearts.size():
		var target_heart = hearts[new_lives] as TextureRect
		target_heart.pivot_offset = Vector2(22, 20)
		target_heart.texture = broken_heart_tex
		var tween = create_tween()
		tween.tween_property(target_heart, "scale", Vector2(1.4, 1.4), 0.1)
		tween.tween_property(target_heart, "modulate:a", 0.0, 0.15)
		tween.tween_callback(func():
			target_heart.texture = empty_heart_tex
			target_heart.scale = Vector2.ONE
		)
		tween.tween_property(target_heart, "modulate:a", 1.0, 0.15)
