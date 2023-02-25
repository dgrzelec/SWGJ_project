extends KinematicBody2D

class_name Enemy

signal EnemyKill

export var health_points = 50

func take_damage(damage):
	print("OWO master, punish me more, I took damage ", damage)

func EnemyKilled():
	emit_signal("EnemyKill")
	queue_free()
