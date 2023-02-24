extends Node2D

class_name Bullet

onready var hitbox = $HitBox
onready var sprite = $Sprite
onready var timer = $Timer
onready var impact_detector = $ImpactDetector

export var damage = 10

export var speed = 100
export var lifetime = 5.0 #in seconds after which bullet is destroyed
var direction = Vector2.ZERO #you have to set direction manually


func _ready():
	
	set_as_toplevel(true)

	hitbox.damage = damage
	look_at(position + direction) #should be vector2
	

	timer.connect("timeout", self, "queue_free")
	timer.start(lifetime)
	
	impact_detector.connect("body_entered", self, "_on_impact")

	

func _physics_process(delta: float):
	position += direction * speed * delta
	

func _on_impact(_body: Node) -> void:
	queue_free()
