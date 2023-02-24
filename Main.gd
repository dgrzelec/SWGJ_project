extends Node



func start_game():
	print("game started")
	
#choosing level etc
func _ready():
	pass



func exit_game():
	get_tree().notification(MainLoop.NOTIFICATION_WM_QUIT_REQUEST)
