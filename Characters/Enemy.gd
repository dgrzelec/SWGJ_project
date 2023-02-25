extends KinematicBody2D

class_name Enemy

signal EnemyKill

export var health_points = 50

onready var _weapon = $Sprite/Weapon

const bullet = preload("res://Weapons/Bullets/RifleBullet.tscn")
const bullet_layer = 16


func _ready():
	_weapon.set_bullet_type(bullet)
	_weapon.set_bullet_layer(bullet_layer)
	_weapon.shoot_dir = Vector2(-1,-1)
	
func _physics_process(_delta):
	if health_points <= 0:
		EnemyKilled()
	shoot_periodically(5.0)
	
func take_damage(damage):
	print("OWO master, punish me more, I took damage ", damage)

func shoot_periodically(time_period: float):
	if _weapon.can_fire:
		_weapon.shoot()
	yield(get_tree().create_timer(time_period), "timeout")


func EnemyKilled():
	emit_signal("EnemyKill")
	queue_free()
