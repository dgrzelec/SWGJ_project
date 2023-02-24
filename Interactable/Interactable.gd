extends Node

class_name Interactable

onready var _area = $InteractionArea

func _ready():
	_area.connect("body_entered", self, "_on_interactable_body_entered")
	_area.connect("body_exited", self, "_on_interactable_body_exited")

func _on_interactable_body_entered(body):
	if body is Player: #check for the right class which interacts
		#warning-ignore:return_value discarded
		body.connect("player_interact", self, "_on_player_interact")
		
func _on_interactable_body_exited(body):
	if body is Player: #check for the right class which interacts
		#warning-ignore:return_value discarded
		if body.is_connected("player_interact", self, "_on_player_interact"):
			body.disconnect("player_interact", self, "_on_player_interact")
		
#Player class is trying to interact - you define what happens here. 
func _on_player_interact(player: Player):
	print("Interaction received from ", player.name)
