extends Node

class_name Weapon

var current_bullet:PackedScene  = null

onready var shoot_pos = $ShootPosition
onready var animation_player = $AnimationPlayer

var shoot_dir = Vector2.ZERO #has to be updated from players side

var can_fire=true
var firerate = 0.5



func _ready():
	pass # Replace with function body.


func set_bullet_type(bullet: PackedScene):
	if bullet == null:
		print("null bullet type")
		return
		
	current_bullet = bullet
	
func shoot():
	if can_fire == true:
		can_fire = false 
		var bullet_instance = current_bullet.instance()
		bullet_instance.position = shoot_pos.global_position
		bullet_instance.direction = shoot_dir
		add_child(bullet_instance)
		yield(get_tree().create_timer(firerate),"timeout")
		can_fire = true
		
		
func shoot_bullet(bullet: PackedScene):
	var bullet_instance = bullet.instance()
	bullet_instance.position = shoot_pos.global_position
	bullet_instance.direction = shoot_dir
	add_child(bullet_instance)

func set_shoot_dir(dir: Vector2):
	shoot_dir = dir
