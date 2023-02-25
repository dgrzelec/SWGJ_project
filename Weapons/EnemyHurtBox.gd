extends HurtBox


func _init() -> void:
	# The hurtbox should detect hits but not deal them. This variable does that.
	monitorable = false

	collision_mask = 8 #detect player bullets
