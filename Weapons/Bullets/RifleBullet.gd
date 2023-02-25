extends Bullet

#parent classes like init (or ready it seems) are called automatically
# so there is no need to call them explicitly when overloading them
func _ready(): 
	
	speed = 400
	hitbox.damage = 13.0
