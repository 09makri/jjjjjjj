extends Node2D

const MAX_LENGTH = 2000

onready var beam = $beam
onready var end = $end
onready var rayCast2D = $RayCast2D

func _physics_process(delta):
	var mouse_position = Global.player.position
	var max_cast_to = mouse_position.normalized() * MAX_LENGTH
	rayCast2D.cast_to = max_cast_to
	if rayCast2D.is_colliding():
		end.global_position = rayCast2D.get_collision_point()
	else:
		end.global_position = rayCast2D.cast_to
	beam.rotation = rayCast2D.cast_to.angle()
	beam.region_rect.end.x = end.position.length()
