extends Area2D


signal respawn_blob


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_deleter_body_entered(body):
	if body.name == "enemy":
		if body.angry == true:
			Global.player.hit(1)
		emit_signal("respawn_blob")
#	yield(get_tree().create_timer(.5), "timeout")
#	body.queue_free()
#	modulate = "ff3232"
#	body.position = get_parent().get_node("enemyspawner").global_position
#	global_position = Vector2(263.538, 0)
