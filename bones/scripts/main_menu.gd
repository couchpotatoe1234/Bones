extends Control

@export_file("*.tscn") var first_level: String

func _on_start_button_pressed() -> void:
	TransitionLayer.change_scene(first_level)
	print("started")

func _on_quit_button_pressed() -> void:
	get_tree().quit()
