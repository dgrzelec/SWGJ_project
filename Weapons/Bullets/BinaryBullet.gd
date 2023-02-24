extends Bullet



func _ready():
	speed = 100

	if randf() >0.5:
		hitbox.damage = 20.0
	else: 
		hitbox.damage = 0.0
