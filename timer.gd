extends Node2D


onready var animplay = $AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_controller_beat(position):
	if position % 2 == 1: #odd
		$Sprite.scale = Vector2(1.3,1.3)
		$Sprite.play("default")
		Global.longertimeshoot = false
		
	if position % 2 == 0: #even
		$Sprite.scale = Vector2(1,1)
		$Sprite.play("light")
		Global.longertimeshoot = true
