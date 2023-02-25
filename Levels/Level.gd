extends Node

class_name Level

onready var _player_spawn = $PlayerSpawnPoint
onready var _enemy_spawn_container = $SpawnLocationContainer
onready var _enemy_container = $EnemyContainer

#load all enemy and bullet scenes
onready var BaseEnemy = load("res://Characters/Enemy.tscn")

onready var BaseWeapon = load("res://Weapons/BaseWeapon.tscn")

onready var RiffleBullet = load("res://Weapons/Bullets/RifleBullet.tscn")


# what enemies will be spawned at this level and with what weapons
onready var enemies = [BaseEnemy]
onready var weapons = [BaseWeapon]
onready var bullets = [RiffleBullet]

#params
var difficulty = 1 # scale parameter for number of enemies and stuff
var enemies_number = difficulty * 3 #placeholder

#scores
export var enemies_killed = 0
var time_to_complete = 999.0



# spawning enemies etc
func _ready():
	enemies_killed = 0
	initiate()

func _process(_delta):
	$Label.text = "Enemies killed: %s" % enemies_killed
	

	
func initiate():
	randomize()
	spawn_random_enemies(enemies_number)

func spawn_random_enemies(count: int):
	var size = enemies.size()
	var spawn_points = _enemy_spawn_container.get_children()
	for i in count:
		var rand_index = randi() % size
		var rand_pos = spawn_points[randi() % spawn_points.size()].position
		spawn_enemy_id(rand_index, rand_pos)
		
		
		
func spawn_enemy_id(id: int, position: Vector2):
	spawn_enemy(enemies[id], position, weapons[id], bullets[id])

func spawn_enemy(enemy: PackedScene, position: Vector2, weapon: PackedScene, bullet: PackedScene):
	var enemy_instance = enemy.instance()
	_enemy_container.add_child(enemy_instance)
	enemy_instance.position = position
	enemy_instance.set_weapon(weapon)
	enemy_instance._weapon.set_bullet_type(bullet)
	#signals
	enemy_instance.connect("EnemyKill", self, "_on_Enemy_kill")
	
	
	
func _on_Enemy_kill():
	enemies_killed += 1
	
	

func get_player_spawn_position():
	return _player_spawn.global_position

