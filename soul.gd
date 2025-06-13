extends Node2D


onready var soul = $CPUParticles2D
signal has_soul

# Called when the node enters the scene tree for the first time.
func _ready():
	soul.emitting = true
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	if body.name == "player":
		emit_signal("has_soul")
		queue_free()
