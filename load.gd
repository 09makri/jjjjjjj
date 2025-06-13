extends CanvasLayer

#var roomArray

onready var waittimer = $waitTimer

func _ready():
	randomize()
#	Global.make_random_int_array(5, 1, 3)
	Global.roomnumber = randi()%4+1
	waittimer.start()



#func _on_waitTimer_timeout():
#	if Global.currentarrayPlace == 0:
#		match Global.roomArray[0]:
#			1:
#				get_tree().change_scene("res://lvl1.tscn")
#			2:
#				get_tree().change_scene("res://lvl2.tscn")
#			3:
#				get_tree().change_scene("res://lvl3.tscn")
#	match Global.roomArray[1]:
#		1:
#			get_tree().change_scene("res://lvl1.tscn")
#		2:
#			get_tree().change_scene("res://lvl2.tscn")
#		3:
#			get_tree().change_scene("res://lvl3.tscn")
#	match Global.roomArray[2]:
#		1:
#			get_tree().change_scene("res://lvl1.tscn")
#		2:
#			get_tree().change_scene("res://lvl2.tscn")
#		3:
#			get_tree().change_scene("res://lvl3.tscn")
#	match Global.roomnumber:
#		1:
#			if Global.oldroomnumber == 1:
#				Global.roomnumber = randi()%4+1
#			else:
#
#				# warning-ignore:return_value_discarded
#				get_tree().change_scene("res://lvl1.tscn")
## 				node = Level2.instance()
## 				get_node("/root/Main/Level1").queue_free()
## 				get_node("/root/Main").add_child(node)
#		2:
#			if Global.oldroomnumber == 2:
#				Global.roomnumber = randi()%4+1
#			else:
#				# warning-ignore:return_value_discarded
#				get_tree().change_scene("res://lvl2.tscn")
#		3:
#			if Global.oldroomnumber == 3:
#				Global.roomnumber = randi()%4+1
#			else:
#				# warning-ignore:return_value_discarded
#				get_tree().change_scene("res://lvl3.tscn")
#		4:
#			if Global.oldroomnumber == 4:
#				Global.roomnumber = randi()%4+1
#			else:
#				get_tree().change_scene("res://lvl4.tscn")
