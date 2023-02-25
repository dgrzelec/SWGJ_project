extends Control


onready var parent = get_parent()


func _on_StartButton_pressed():
	parent.start_game()


func _on_ExitButton_pressed():
	parent.exit_game()
