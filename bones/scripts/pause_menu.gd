extends Control

func _ready() -> void:
	hide()

func toggle_pause() -> void:
	get_tree().paused = !get_tree().paused
	visible = get_tree().paused
	
func _on_resume_button_pressed() -> void:
	print("unpause")
	toggle_pause() 
	
func _on_quit_button_pressed() -> void:
	print("quit")
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
