extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
#	$Icon/Timer.wait_time = Global.sec_perbeat


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Global.playerdead == true:
		$deadtimer.start()
	$CanvasLayer/Control/Label.text = var2str(Global.score)


func _on_controller_beat(position):
	if position % 2 == 1: #odd
		Global.playercanshoot = false
		
	if position % 2 == 0: #even
#		yield(get_tree().create_timer(0.4), "timeout")
		Global.playercanshoot = true
		
#	if position % 2 == 1: #odd
#		$Icon.hide()
		
#	if position % 2 == 0: #even
#		$Icon.show()
#		$Icon/Timer.start()


func _on_Timer_timeout():
	$Icon.hide()


func _on_deadtimer_timeout():
	get_tree().change_scene("res://menu.tscn")
