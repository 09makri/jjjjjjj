extends KinematicBody2D

const speed = 35


#onready var player = get_parent().get_parent().get_parent().get_node("player")
onready var player = Global.player

func _physics_process(delta):
	var dir = (Global.player.global_position - global_position).normalized()
	move_and_slide(dir * speed )



