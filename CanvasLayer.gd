extends CanvasLayer


onready var health1 = $all/health3/full
onready var health2 = $all/health3/half
onready var health3 = $all/health2/full
onready var health4 = $all/health2/half
onready var health5 = $all/health/full
onready var health6 = $all/health/half




func _ready():
	$all/transitionshader.hide()
#	health1.show()
#	health2.show()
#	health3.show()
#	health4.show()
#	health5.show()
#	health6.show()


# warning-ignore:unused_argument
func _process(delta):
#	var fps = Engine.get_frames_per_second()
#	$all/Label2.text = var2str(fps)
	$all/Label.text = var2str(Global.playerhealth)
	if Global.playerhealth == 6:
		health1.show()
		health2.show()
		health3.show()
		health4.show()
		health5.show()
		health6.show() 
	if Global.playerhealth == 5:
		health1.hide()
		health2.show()
		health3.show()
		health4.show()
		health5.show()
		health6.show() 
	if Global.playerhealth == 4:
		health1.hide()
		health2.hide()
		health3.show()
		health4.show()
		health5.show()
		health6.show() 
	if Global.playerhealth == 3:
		health1.hide()
		health2.hide()
		health3.hide()
		health4.show()
		health5.show()
		health6.show() 
	if Global.playerhealth == 2:
		health1.hide()
		health2.hide()
		health3.hide()
		health4.hide()
		health5.show()
		health6.show()
	if Global.playerhealth == 1:
		health1.hide()
		health2.hide()
		health3.hide()
		health4.hide()
		health5.hide()
		health6.show() 
	if Global.playerhealth <= 0:
		Global.playerhealth = 6
#		Global.player.dead()
		get_parent().get_node("ScreenShake").screen_shake(0.3, 6, 1)
		$all/restrtTimer.start()
#		get_tree().reload_current_scene()


func _on_restrtTimer_timeout():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://menu.tscn")
