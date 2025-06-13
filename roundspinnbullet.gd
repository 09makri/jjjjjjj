extends KinematicBody2D
#normal spinning bullet


var direction : Vector2 = Vector2.LEFT # default direction
var speed : float = 400 #put your rocket speed

func _physics_process(delta):
	translate(direction*speed*delta)



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
	if body.name == "tiles":
		queue_free()
#	if body.name != "roundspinnbullet": 
#		queue_free()


# warning-ignore:unused_argument
func _on_Area2D_area_entered(area):
	pass
#	if area.name != "roundspinhit":
#		queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
