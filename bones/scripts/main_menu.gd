extends Control


func _on_start_button_pressed() -> void:
	MusicController.get_node("Button").play()
	TransitionLayer.change_scene(GameManager.current_level)

func _on_quit_button_pressed() -> void:
	MusicController.get_node("Button").play()
	get_tree().quit()
	
func _ready() -> void:
	MusicController.get_node("Music").stop()
