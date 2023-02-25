extends KinematicBody2D

class_name Player

signal player_interact

onready var _animation_player = $AnimationPlayer
onready var _sprite = $Sprite
onready var _weapon = $Sprite/BodySprite/FrontPaw/Weapon
onready var _paw = $Sprite/BodySprite/FrontPaw

const bullet = preload("res://Weapons/Bullets/RifleBullet.tscn")
#states
var jumping = false
var midair = false
var has_weapon = true

#controls
var jump_button = false
var direction = 0 #left -1/right 1

#params
var max_speed = 400.0
var max_speed_y = 800.0
var forward_acc = 1500.0
var back_acc = 2000.0

var gravity_acc = 4000.0

var jump_speed = 500.0

var jump_time_limit = 0.5
var jump_buffer_time = 2.0 * 1.0/60.0

var stay_on_platform_time_limit = 4 * 1.0/60.0

#vars
var speed = 0.0
export var velocity = Vector2.ZERO

var flip_sprite = false

var left_platform_time = 0.0
var jump_time = 0.0

func _ready():
	_weapon.set_bullet_type(bullet)
	if has_weapon:
		_animation_player.play("idle_with_weapon")
	else:
		_animation_player.play("idle")

func get_input():
	if Input.is_action_just_pressed("interact"):
		emit_signal("player_interact", self)
	
	if Input.is_action_pressed("jump"):
		jump_button = true
	else:
		buffer_jump()
	
	direction = 0
	
	if Input.is_action_pressed("left"):
		direction -= 1
#		_weapon.shoot_dir = Vector2.LEFT
	if Input.is_action_pressed("right"):
		direction += 1
#		_weapon.shoot_dir = Vector2.RIGHT
	
	if Input.is_action_just_pressed("shoot"):
		
		_weapon.shoot()

func _physics_process(delta):
	get_input()
	
	if direction:
		flip_sprite = !bool(direction + 1)
	if flip_sprite and _sprite.scale.x > 0:
		_sprite.scale.x *= -1
	elif not flip_sprite and _sprite.scale.x < 0:
		_sprite.scale.x *= -1
	
	velocity = move_and_slide(velocity, Vector2.UP)
	## check for state change

	if not is_on_floor():
		coyote_time()

	if jump_button and not midair:
		jumping = true
	elif not jump_button or jump_time > jump_time_limit:
		jumping = false
		jump_time = 0.0
		
	if jumping:
		## animation
#		_animation_player.stop()
#		_animation_player.play("jump_transition", -1, 0.35/jump_time_limit)
		#####
		jump_time += delta
		
		velocity.y = -jump_speed
#		apply_gravity(delta)
		midair = true
		
	if midair:
		apply_gravity(delta)
		
#		if not jumping:
#			_animation_player.play("jumping")
		if is_on_floor():
#			_animation_player.play("landing")
			midair = false
			
			
	
	if direction:

		if not midair and not jumping:
			if has_weapon:
				_animation_player.play("running_with_weapon")
			else:
				_animation_player.play("running_no_weapon")
		
		if sign(velocity.x) == direction:
			velocity.x += direction * forward_acc * delta
			
		else:
			velocity.x += direction * back_acc * delta
		
			
	else: #direction==0
		# animation
		if not midair and not jumping:
			if has_weapon:
				_animation_player.play("idle_with_weapon")
			else:
				_animation_player.play("idle")
		###############
		
		velocity.x -= sign(velocity.x) * back_acc * delta
		if abs(velocity.x) < 10: velocity.x = 0.0
	
	
	velocity.x = clamp(velocity.x, -max_speed, max_speed)
	velocity.y = clamp(velocity.y, -max_speed_y, max_speed_y)
	
	# some gravity to keep character on the ground
	velocity.y += 100 * delta

	#weapons and stuff
	var mouse_pos = get_global_mouse_position()
	point_paw_at(mouse_pos)
	_weapon.shoot_dir = _weapon.get_node("ShootPosition").global_position.direction_to(mouse_pos)
	
func coyote_time():
	yield(get_tree().create_timer(stay_on_platform_time_limit, false), "timeout")
	midair = true

func buffer_jump():
	yield(get_tree().create_timer(jump_buffer_time, false), "timeout")
	jump_button = false
	
func apply_gravity(delta):
	velocity.y += gravity_acc * delta

#animating paw
func point_paw_at(_direction: Vector2):
	_paw.look_at(_weapon.get_node("ShootPosition").global_position.direction_to(_direction))
	_paw.rotation_degrees += -90
