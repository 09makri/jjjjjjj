extends Node2D

signal player_passed_door
onready var anim = $AnimatedSprite
onready var coll = $StaticBody2D/CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready():
	anim.play("open")
	coll.set_deferred("disabled",true)

func _on_Area2D_body_entered(body):
	if body.name == "player":
		anim.play("close")
		coll.set_deferred("disabled",false)
		emit_signal("player_passed_door") 
	


