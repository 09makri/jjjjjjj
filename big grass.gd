extends Node2D


onready var anim = $AnimatedSprite


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


#func _process(delta):
#	if 


func _on_Area2D_body_entered(body):
	if body.name == "player":
		anim.play("left")
	if body.is_in_group("enemy"):
		anim.play("left")


func _on_AnimatedSprite_animation_finished():
	anim.stop()
	anim.frame = 0


func _on_Area2D2_body_entered(body):
	if body.name == "player":
		anim.play("walk")
	if body.is_in_group("enemy"):
		anim.play("walk")
