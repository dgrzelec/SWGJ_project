# Allows its owner to detect hits and take damage
extends Area2D

class_name HurtBox, "HurtBox.svg"


func _init() -> void:
	# The hurtbox should detect hits but not deal them. This variable does that.
	monitorable = false

	collision_mask = 2


func _ready() -> void:
	connect("area_entered", self, "_on_area_entered")


func _on_area_entered(hitbox: HitBox) -> void:
	if hitbox == null:
		return
#	print("hitbox")
	if owner.has_method("take_damage"):
		owner.take_damage(hitbox.damage)
	hitbox.emit_signal("hit")
