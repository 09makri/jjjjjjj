extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("blob")
	play_randomized("blob")


func play_randomized(animation_name : String):
	randomize()
	$AnimationPlayer.play(animation_name)
	var offset : float = rand_range(0, $AnimationPlayer.current_animation_length)
	$AnimationPlayer.advance(offset)
