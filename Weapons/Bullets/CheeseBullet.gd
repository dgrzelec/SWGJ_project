extends Bullet

func _ready():
	hitbox.damage = 8.0

func _on_impact(_body: Node) -> void:
	#if body is_type("Enemy"):
		#_body.stagger()
	#queue_free()
	pass
