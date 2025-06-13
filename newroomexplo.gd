extends Node2D

var active = false
onready var anim = $AnimatedSprite
const shakeonetrigger = preload("res://screenshakeonetrigger.tscn")

# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass
#	var shaketriggerinst = shakeonetrigger.instance()
#	get_tree().current_scene.add_child(shaketriggerinst)
#	get_tree().current_scene.call_deferred("add_child", shaketriggerinst)

#func _process(delta):
#	pass
#	if active == true:
#		get_parent().get_node("ScreenShake").screen_shake(0.5, 5, 9)

func _new_room_anim():
	active = true
	anim.play("active")
#	var shaketriggerinst = shakeonetrigger.instance()
#	get_tree().current_scene.call_deferred("add_child", shaketriggerinst)
	$exploTimer.start()


func _on_newroomcoll_body_entered(body):
	if body.name == "player":
		Global._random_room()


func _on_exploTimer_timeout():
	active = false
