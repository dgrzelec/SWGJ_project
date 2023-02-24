extends Node2D

class_name Bullet

onready var hitbox = $HitBox
onready var sprite = $Sprite
onready var timer = $Timer
onready var impact_detector = $ImpactDetector

var damage = 10

export var speed = 100
export var lifetime = 5.0 #in seconds after which bullet is destroyed
var direction = Vector2.ZERO #you have to set direction manually


func _init():
	hitbox.damage = damage
	
	set_as_toplevel(true)
	
	look_at(owner.shoot_dir) #should be vector2

	timer.connect("timeout", self, "destroy")
	timer.start(lifetime)
	
	impact_detector.connect("body_entered", self, "_on_impact")

func _physics_process(delta: float):
	position += direction * speed * delta
	

func _on_impact(_body: Node) -> void:
	queue_free()
