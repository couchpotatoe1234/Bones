extends Control

func _ready() -> void:
	hide()

func toggle_pause() -> void:
	get_tree().paused = !get_tree().paused
	visible = get_tree().paused
	
func _on_resume_button_pressed() -> void:
	toggle_pause() 
	
	
func _on_quit_button_pressed() -> void:
	get_tree().paused = false
	TransitionLayer.change_scene("res://scenes/main_menu.tscn")
