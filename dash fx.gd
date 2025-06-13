extends Node2D


onready var anim = $AnimatedSprite
var rot


func _ready():
	randomize()
	anim.play("dash")
	rot = rand_range(-80, 30)
	anim.rotation_degrees = rot
	




