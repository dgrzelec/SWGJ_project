extends KinematicBody2D

class_name Enemy

signal EnemyKill

export var health_points = 50

onready var _weapon = $Sprite/Weapon
onready var _weapon_pos = $WeaponPosition

const bullet = preload("res://Weapons/Bullets/RifleBullet.tscn")
const bullet_layer = 16


func _ready():
	_weapon.set_bullet_type(bullet)
	_weapon.set_bullet_layer(bullet_layer)
	_weapon.shoot_dir = Vector2(-1,-1)
	
func _physics_process(_delta):
	if health_points <= 0:
		EnemyKilled()
	shoot_periodically()
	
func take_damage(damage):
	print("OWO master, punish me more, I took damage ", damage)
	health_points -= damage

func shoot_periodically():
	if _weapon.can_fire:
		_weapon.shoot()
#	yield(get_tree().create_timer(time_period), "timeout")

func set_weapon(new_weapon: PackedScene):
	_weapon.queue_free()
	_weapon = new_weapon.instance()
	_weapon.position = _weapon_pos.position
	_weapon.shoot_dir = Vector2(-1,-1) #placeholder for tests
	_weapon.set_bullet_layer(bullet_layer)
	#maybe some adjustments to rotation
	$Sprite.add_child(_weapon)
	
func get_weapon_pos():
	return _weapon_pos.global_position

func EnemyKilled():
	emit_signal("EnemyKill")
	print("I'm ded")
	_weapon.queue_free()
	queue_free()
