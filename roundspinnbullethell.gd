extends KinematicBody2D
#tailord for bullet hell

const speed = 100

func _process(delta):
	position += transform.x * speed * delta



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


#func _on_roundspinnbullet_body_entered(body):
#	queue_free()


func _on_Area2D_body_entered(body):
	if body.name == "player":
		Global.player.hit(1)
	if body.name == "TileMap" or body.name == "TileMap3":
		queue_free()
#	if body.name != "roundspinnbullet": 
#		queue_free()


func _on_Area2D_area_entered(_area):
	pass
#	if area.name != "roundspinhit":
#		queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
