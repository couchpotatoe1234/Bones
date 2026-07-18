extends Control

@export_file("res://scenes/game.tscn") var first_level: String


func _on_start_button_pressed() -> void:
	TransitionLayer.change_scene(first_level)

func _on_HTP_button_pressed() -> void:
	TransitionLayer.change_scene("res://scenes/how_to_play.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().quit()
