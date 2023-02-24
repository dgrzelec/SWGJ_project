extends Label

onready var animation_player = $AnimationPlayer

func _ready():
	visible = false
	

func show_text_animated(message: String):
	visible = true
	text = message
	animation_player.stop(true)
	animation_player.play("text_fill")
	
