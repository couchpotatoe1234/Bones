extends CanvasLayer

@onready var animation_player = $ColorRect/AnimationPlayer

func change_scene(target_scene_path: String) -> void:
	animation_player.play("fade_to_black")
	await animation_player.animation_finished
	get_tree().change_scene_to_file.call_deferred(target_scene_path)
	animation_player.play("fade_to_normal")
