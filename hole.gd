extends Node2D

onready var anim = $AnimatedSprite
#signal loadingscreen

func _ready():
	anim.play("active")

func _on_Area2D_body_entered(body):
	if body.name == "player":
#		Global.loadingvar = true
#		emit_signal("loadingscreen")
		Global._random_room()
