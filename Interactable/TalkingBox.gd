extends Interactable
onready var label = $AnimatedLabel

func _on_player_interact(player: Player):
	if player == null:
		return
	label.show_text_animated("Hello, %s" % player.name)
