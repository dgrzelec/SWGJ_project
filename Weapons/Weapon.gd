extends Node

class_name Weapon

var current_bullet:PackedScene  = null

onready var shoot_pos = $ShootPosition
onready var animation_player = $AnimationPlayer

var shoot_dir = Vector2.ZERO #has to be updated from players side

var _bullet_layer = 0


func _ready():
	pass # Replace with function body.


func set_bullet_type(bullet: PackedScene):
	if bullet == null:
		print("null bullet type")
		return
		
	current_bullet = bullet
	
func shoot():
	var bullet_instance = current_bullet.instance()
	bullet_instance.position = shoot_pos.global_position
	bullet_instance.direction = shoot_dir
	bullet_instance.get_node("HitBox").collision_layer = _bullet_layer
	add_child(bullet_instance)
	
func shoot_bullet(bullet: PackedScene):
	var bullet_instance = bullet.instance()
	bullet_instance.position = shoot_pos.global_position
	bullet_instance.direction = shoot_dir
	bullet_instance.get_node("HitBox").collision_layer = _bullet_layer
	add_child(bullet_instance)

func set_shoot_dir(dir: Vector2):
	shoot_dir = dir

func set_bullet_layer(layer: int):
	_bullet_layer = layer
