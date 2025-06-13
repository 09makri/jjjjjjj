extends Node2D

signal dash
onready var timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	if body.name == "player":
		Global.player.can_dash = true
		emit_signal("dash")
#		Global.player.gravity = 0
#		Engine.time_scale = 0.5
		queue_free()


func _on_Timer_timeout():
	Engine.time_scale = 1
	
