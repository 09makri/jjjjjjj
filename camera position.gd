extends Node2D


export var position_x = 512
export var position_y = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	if body.name == "player":
		get_parent().get_node("Camera2D").position = Vector2(position_x, position_y)
