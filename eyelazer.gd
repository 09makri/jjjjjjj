extends KinematicBody2D

onready var laser := $LaserBeam2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

#func _unhandled_input(event: InputEvent) -> void:
#	if not event.is_action("fire_weapon"):
#		return
#	laser.is_casting = event.is_action_pressed("fire_weapon")
	
func _process(delta):
#	laser.is_casting = true
#	while laser.is_casting == true:
#		laser.is_casting
	look_at(Global.player.global_position)
#	laser.is_casting = true
