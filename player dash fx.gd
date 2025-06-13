extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.play("active")
	if Global.playerdir == 1:
		$AnimatedSprite.flip_h = false
	else:
		$AnimatedSprite.flip_h = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
