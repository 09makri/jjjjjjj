extends Node2D


onready var laser := $LaserBeam2D


func _process(_delta: float) -> void:
	look_at(get_global_mouse_position())


func _unhandled_input(event: InputEvent) -> void:
	if not event.is_action("fire_weapon"):
		return
	laser.is_casting = event.is_action_pressed("fire_weapon")
