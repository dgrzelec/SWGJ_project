# Detected by HurtBox
extends Area2D

class_name HitBox, "HitBox.svg"

export var damage := 10

signal hit

func _init() -> void:
	collision_mask = 0
	# This turns off collision mask bit 1 and turns on bit 2. It's the physics layer we reserve to hurtboxes in this demo.
	collision_layer = 2
