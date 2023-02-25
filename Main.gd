extends Node



func start_game():
	print("game started")
	$UI.show()
	$MainMenu.hide()
	
#choosing level etc
func _ready():
	pass



func exit_game():
	get_tree().notification(MainLoop.NOTIFICATION_WM_QUIT_REQUEST)
