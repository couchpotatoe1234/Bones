extends Control


func _on_start_button_pressed() -> void:
	TransitionLayer.change_scene(GameManager.current_level)

func _on_quit_button_pressed() -> void:
	get_tree().quit()
